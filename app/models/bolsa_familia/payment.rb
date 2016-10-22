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

    # Ranking
    scope :people_ranking, lambda {
      select('nome_municipio, uf, nome_favorecido, SUM(valor_parcela)')
        .group(:nis_favorecido, :nome_municipio, :uf, :nome_favorecido)
    }
    scope :state_ranking, -> { select('uf, SUM(valor_parcela)').group(:uf) }

    # Filter data
    scope :by_year, ->(year) { where('EXTRACT(year from data_competencia) = ?', year) }
    scope :by_year_and_month, lambda { |year, month|
      where('DATE(data_competencia) = ?', Date.new(year, month, 1))
    }
    scope :by_state, ->(state) { where(uf: state) }

    # Order data
    scope :ranking_order, -> { order('SUM(valor_parcela) DESC') }
  end
end
