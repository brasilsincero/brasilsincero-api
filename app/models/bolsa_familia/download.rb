require 'net/http'
require 'zip/zip'

module BolsaFamilia
  class Download
    def self.perform(month, year)
      Rails.logger = Logger.new(STDOUT)
      compressed_file = download(filename, month, year)
      decompressed_file = decompress(compressed_file)
      save_head(decompressed_file)
    end

    def self.download(filename, month, year)
      formatted_month = format('%02d', month.to_i)
      filename = "tmp/#{year}#{formatted_month}_BolsaFamiliaFolhaPagamento.zip"
      Rails.logger.info "Downloading to #{filename}"

      Net::HTTP.start('arquivos.portaldatransparencia.gov.br') do |http|
        url = "/downloads.asp?a=#{year}&m=#{formatted_month}&consulta=BolsaFamiliaFolhaPagamento"
        response = http.get(url)
        open(filename, 'wb') { |file| file.write(response.body) }
      end

      Rails.logger.info "Finished download of #{filename}"
      filename
    end

    def self.decompress(compressed_file)
      dest_file = compressed_file.gsub('zip', 'csv')
      Zip::ZipFile.open(compressed_file) do |zip_file|
        zip_file.each do |entry|
          Rails.logger.info "Extracting #{entry.name}"
          entry.extract(dest_file)
        end
      end
      Rails.logger.info "Removing #{compressed_file}"
      FileUtils.rm(compressed_file)
      dest_file
    end

    def self.save_head(decompressed_file)
      short_file = decompressed_file.gsub(/\.csv/, '_1_000_000.csv')
      Rails.logger.info "Creating #{short_file}"
      system "head -1000000 #{decompressed_file} > #{short_file}"

      Rails.logger.info "Removing #{decompressed_file}"
      FileUtils.rm(decompressed_file)
    end
  end
end
