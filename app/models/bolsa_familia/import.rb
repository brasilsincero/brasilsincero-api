module BolsaFamilia
  class Import
    def self.perform(month, year)
      Rails.logger = Logger.new(STDOUT)
      filename = BolsaFamilia.generate_filename(month, year)
      embulk_file = 'lib/embulk/bolsa_familia.yml.liquid'
      Rails.logger.info "Importing #{filename} with #{embulk_file}"
      Bundler.with_clean_env do
        system "path_prefix='#{filename}' embulk run -b lib/embulk/embulk_bundle #{embulk_file}"
      end
      Rails.logger.info "Finished importing #{filename}"
    end
  end
end
