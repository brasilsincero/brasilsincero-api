module BolsaFamilia
  class Import
    def self.perform(month, year)
      Rails.logger = Logger.new(STDOUT)
      filename = BolsaFamilia.generate_filename(month, year)
      Rails.logger.info "Importing #{filename}"
      system "path_prefix='#{filename}' embulk run lib/embulk/bolsa_familia.yml.liquid"
      Rails.logger.info "Finished importing #{filename}"
    end
  end
end
