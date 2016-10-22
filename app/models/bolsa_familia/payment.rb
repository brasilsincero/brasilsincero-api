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
  end
end
