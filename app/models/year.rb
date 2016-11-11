class Year
  def self.find(year = nil)
    (year || Time.current.year).to_i.tap do |normalized_year|
      raise RecordNotFound, 'Year not found' unless all.include?(normalized_year)
    end
  end

  def self.all
    (BolsaFamilia::Infrastructure::FIRST_YEAR..Time.current.year)
  end
end
