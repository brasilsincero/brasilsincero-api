module V1
  module BolsaFamilia
    class PaymentsStatesController < ApplicationController
      include BolsaFamiliaResponse

      def index
        ranking = Rails.cache.fetch("bolsa_familia/payments_states/#{year}") do
          ::BolsaFamilia::Payment.state_ranking
                                 .by_year(year)
                                 .ranking_order
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
