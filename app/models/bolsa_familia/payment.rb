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
    scope :ranking_columns, lambda {
      select('nome_municipio, uf, nome_favorecido, MAX(valor_parcela)')
    }

    # Filter data
    scope :by_year, ->(year) { where('EXTRACT(year from data_competencia) = ?', year) }
    scope :by_year_and_month, lambda { |year, month|
      where('DATE(data_competencia) = ?', Date.new(year, month, 1))
    }
    scope :by_state, ->(state) { where(uf: state) }

    # Order data
    scope :ranking_order, -> { order('MAX(valor_parcela) DESC') }

    # Group data
    scope :ranking_unique_people, lambda {
      group(:nis_favorecido, :nome_municipio, :uf, :nome_favorecido)
    }
  end
end
