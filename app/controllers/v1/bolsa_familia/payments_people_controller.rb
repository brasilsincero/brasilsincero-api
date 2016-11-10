module V1
  module BolsaFamilia
    class PaymentsPeopleController < ApplicationController
      include RecordNotFoundHandler

      def index
        render json: {
          year: year,
          number_of_people: number_of_people,
          money_spent: money_spent,
          ranking: ranking
        }
      end

      private

      def ranking
        Rails.cache.fetch("bolsa_familia/payments_people/ranking/#{year}/#{state}") do
          ::BolsaFamilia::Payment.people_ranking
                                 .by_year(year)
                                 .by_state(state)
                                 .ranking_order
                                 .limit(50)
                                 .as_json
        end
      end

      def number_of_people
        Rails.cache.fetch("bolsa_familia/payments_people/number_of_people/#{year}/#{state}") do
          ::BolsaFamilia::Payment.by_year(year).by_state(state).count
        end
      end

      def money_spent
        Rails.cache.fetch("bolsa_familia/payments_people/money_spent/#{year}/#{state}") do
          ::BolsaFamilia::Payment.money_spent.by_year(year).by_state(state).first.sum
        end
      end

      def state
        @state ||= State.find(params[:state])
      end

      def year
        params[:year] || Time.current.year
      end
    end
  end
end
