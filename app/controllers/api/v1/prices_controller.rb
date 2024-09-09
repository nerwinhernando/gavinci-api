module Api
  module V1
    class PricesController < ApplicationController
      before_action :set_price, only: [:show, :update, :destroy]

      def index
        @prices = Price.all
        render json: @prices
      end

      def show
        render json: @price
      end

      def create
        @price = Price.new(price_params.merge(user: @current_user))
        if @price.save
          render json: @price, status: :created
        else
          render json: @price.errors, status: :unprocessable_entity
        end
      end

      def update
        if @price.update(price_params)
          render json: @price
        else
          render json: @price.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @price.destroy
        head :no_content
      end

      def latest_by_station
        @prices = Price.where(station_id: params[:station_id])
                       .order(created_at: :desc)
                       .group_by(&:fuel_type_id)
                       .transform_values(&:first)
        render json: @prices
      end

      private

      def set_price
        @price = Price.find(params[:id])
      end

      def price_params
        params.require(:price).permit(:station_id, :fuel_type_id, :amount, :is_confirmed)
      end
    end
  end
end
