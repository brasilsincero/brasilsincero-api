module V1
  module BolsaFamilia
    class PaymentsPeopleController < ApplicationController
      def index
        ranking = Rails.cache.fetch("bolsa_familia/payments_people/#{year}") do
          ::BolsaFamilia::Payment.people_ranking
                                 .by_year(year)
                                 .ranking_order
                                 .limit(50)
                                 .map(&:as_json)
        end
        render json: ranking, status: :ok
      end

      private

      def year
        params[:year] || Time.current.year
      end
    end
  end
end
