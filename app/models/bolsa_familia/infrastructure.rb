module BolsaFamilia
  class Infrastructure
    FIRST_YEAR = 2011

    def self.create
      Rails.logger.info 'Creating infrastructure'
      (FIRST_YEAR..Time.current.year).each do |year|
        (1..12).each do |month|
          partition_date = Date.new(year, month, 1)
          bolsa_familia_payment = Payment.new(data_competencia: partition_date)
          bolsa_familia_payment.create_partition_from_record
        end
      end
    end
  end
end
