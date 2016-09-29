require 'rails_helper'

describe BolsaFamiliaPaymentConverter do
  describe '.convert' do
    let(:params) do
      { 'mes_competencia' => '01/2015', 'valor_parcela' => '100.0' }
    end

    it 'returns all except mes_competencia key' do
      expect(described_class.convert(params).keys).not_to include('mes_competencia')
    end

    it 'converts valor_parcela to float' do
      expect(described_class.convert(params)['valor_parcela']).to eql 100.0
    end

    it 'converts mes_competencia to a date' do
      expect(described_class.convert(params)['data_competencia']).to eql Date.new(2015, 1, 1)
    end
  end
end
