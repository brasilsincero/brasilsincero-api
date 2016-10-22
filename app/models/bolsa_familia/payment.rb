module BolsaFamilia
  class Payment < ApplicationRecord
    include Partitionable::ActsAsPartitionable

    acts_as_partitionable index_fields:
      %w(
        uf
        nome_municipio
        nome_favorecido
        valor_parcela
        nis_favorecido
        data_competencia
      ), logdate_attr: 'data_competencia'

    def as_json(options = {})
      super(options.merge(except: :id))
    end

    # Filter columns
    scope :main_columns, lambda {
      select('nome_municipio, uf, nome_favorecido, valor_parcela, data_competencia')
    }

    # Filter data
    scope :by_year, ->(year) { where('EXTRACT(year from data_competencia) = ?', year) }
    scope :by_year_and_month, lambda { |year, month|
      where('DATE(data_competencia) = ?', Date.new(year, month, 1))
    }
    scope :by_state, ->(state) { where(uf: state) }

    # Order data
    scope :ordered_by_value, -> { order(valor_parcela: :desc) }
  end
end
