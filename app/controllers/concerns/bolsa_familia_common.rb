module BolsaFamiliaCommon
  extend ActiveSupport::Concern

  included do
    def index
      render json: {
        year: year,
        number_of_people: number_of_people,
        money_spent: money_spent,
        ranking: ranking
      }
    end

    def number_of_people
      Rails.cache.fetch("bolsa_familia/number_of_people/#{year}/#{state}") do
        ::BolsaFamilia::Payment.by_year(year).by_state(state).count
      end
    end

    def money_spent
      Rails.cache.fetch("bolsa_familia/money_spent/#{year}/#{state}") do
        ::BolsaFamilia::Payment.money_spent.by_year(year).by_state(state).first.sum
      end
    end

    private

    def state
      @state ||= State.find(params[:state])
    end

    def year
      @year ||= Year.find(params[:year])
    end
  end
end
