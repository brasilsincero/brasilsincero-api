module V1
  module BolsaFamilia
    class YearlyCostsController < ApplicationController
      def index
        money_spent = Rails.cache.fetch('bolsa_familia/yearly_costs/money_spent') do
          (::BolsaFamilia::Infrastructure::FIRST_YEAR..Time.current.year).map do |year|
            {
              year: year,
              money_spent: money_spent(year)
            }
          end
        end

        render json: money_spent
      end

      private

      def money_spent(year)
        Rails.cache.fetch("bolsa_familia/money_spent/#{year}/") do
          ::BolsaFamilia::Payment.money_spent.by_year(year).first.sum
        end
      end
    end
  end
end
