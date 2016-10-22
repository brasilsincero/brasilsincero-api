module V1
  module BolsaFamilia
    class PaymentsRankingController < ApplicationController
      def index
        ranking = Rails.cache.fetch("bolsa_familia/payments_ranking/#{year}") do
          ::BolsaFamilia::Payment.ranking_columns
                                 .by_year(year)
                                 .ranking_unique_people
                                 .ranking_order
                                 .limit(50)
        end
        render json: ranking, status: :ok
      end

      private

      def year
        params[:year] || Time.current.year
      end

      def state
        params[:state]
      end
    end
  end
end
