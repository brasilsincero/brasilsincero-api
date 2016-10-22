module V1
  module BolsaFamilia
    class PaymentsPeopleController < ApplicationController
      include BolsaFamiliaResponse

      def index
        ranking = Rails.cache.fetch("bolsa_familia/payments_people/#{year}") do
          ::BolsaFamilia::Payment.people_ranking
                                 .by_year(year)
                                 .ranking_order
                                 .limit(50)
                                 .as_json
        end

        render json: year_response(ranking, year), status: :ok
      end

      private

      def year
        params[:year] || Time.current.year
      end
    end
  end
end
