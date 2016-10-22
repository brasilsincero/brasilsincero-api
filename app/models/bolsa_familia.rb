module BolsaFamilia
  def self.table_name_prefix
    'bolsa_familia_'
  end

  def self.generate_filename(month, year)
    "tmp/#{year}_#{month}_bolsa_familia.csv"
  end
end
