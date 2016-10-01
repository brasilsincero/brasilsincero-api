require 'net/http'
require 'zip/zip'

module BolsaFamilia
  class Download
    def self.perform(month, year)
      Rails.logger = Logger.new(STDOUT)
      formatted_month = format('%02d', month.to_i)
      filename = "tmp/#{year}#{formatted_month}_BolsaFamiliaFolhaPagamento.zip"
      download(filename, formatted_month, year)
      decompress(filename)
    end

    def self.download(filename, month, year)
      Rails.logger.info "Downloading to #{filename}"

      Net::HTTP.start('arquivos.portaldatransparencia.gov.br') do |http|
        url = "/downloads.asp?a=#{year}&m=#{month}&consulta=BolsaFamiliaFolhaPagamento"
        response = http.get(url)
        open(filename, 'wb') do |file|
          file.write(response.body)
        end
      end

      Rails.logger.info "Finished download of #{filename}"
    end

    def self.decompress(filename)
      dest_file = filename.gsub('zip', 'csv')
      Zip::ZipFile.open(filename) do |zip_file|
        zip_file.each do |entry|
          Rails.logger.info "Extracting #{entry.name}"
          entry.extract(dest_file)
        end
      end
      Rails.logger.info "Removing #{filename}"
      FileUtils.rm(filename)
    end
  end
end
