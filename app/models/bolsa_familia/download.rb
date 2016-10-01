require 'net/http'
require 'zip/zip'

module BolsaFamilia
  class Download
    def self.perform(month, year)
      Rails.logger = Logger.new(STDOUT)
      filename = BolsaFamilia.generate_filename(month, year)
      compressed_file = download(month, year)
      decompressed_file = decompress(compressed_file)
      save_head(filename, decompressed_file)
    end

    def self.download(month, year)
      formatted_month = format('%02d', month.to_i)
      filename = "tmp/#{year}_#{month}_bolsa_familia_full.zip"
      Rails.logger.info "Downloading in #{filename}"

      Net::HTTP.start('arquivos.portaldatransparencia.gov.br') do |http|
        url = "/downloads.asp?a=#{year}&m=#{formatted_month}&consulta=BolsaFamiliaFolhaPagamento"
        response = http.get(url)
        open(filename, 'wb') { |file| file.write(response.body) }
      end

      Rails.logger.info "Finished downloading #{filename}"
      filename
    end

    def self.decompress(compressed_file)
      decompressed_file = compressed_file.gsub('zip', 'csv')
      Zip::ZipFile.open(compressed_file) do |zip_file|
        zip_file.each do |entry|
          Rails.logger.info "Extracting #{entry.name} to #{decompressed_file}"
          entry.extract(decompressed_file)
        end
      end
      Rails.logger.info "Removing #{compressed_file}"
      FileUtils.rm(compressed_file)
      decompressed_file
    end

    def self.save_head(filename, decompressed_file)
      Rails.logger.info "Creating #{filename}"
      system "head -1000000 #{decompressed_file} > #{filename}"

      Rails.logger.info "Removing #{decompressed_file}"
      FileUtils.rm(decompressed_file)
    end
  end
end
