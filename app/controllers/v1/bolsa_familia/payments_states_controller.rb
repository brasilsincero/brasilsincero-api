module V1
  module BolsaFamilia
    class PaymentsStatesController < ApplicationController
      include RecordNotFoundHandler

      def index
        render json: {
          year: year,
          ranking: ranking
        }
      end

      private

      def ranking
        Rails.cache.fetch("bolsa_familia/payments_states/ranking/#{year}") do
          ::BolsaFamilia::Payment.state_ranking
                                 .by_year(year)
                                 .ranking_order
                                 .as_json
        end
      end

      def year
        @year ||= Year.find(params[:year])
      end
    end
  end
end
