class BolsaFamiliaPaymentConverter
  def self.convert(row)
    row.tap do |new_row|
      new_row['valor_parcela'] = row['valor_parcela'].to_f
      new_row['data_competencia'] = Date.parse("01/#{row['mes_competencia']}")
    end.except('mes_competencia')
  end
end
