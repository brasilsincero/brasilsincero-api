class BolsaFamiliaPayment < ApplicationRecord
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
end
