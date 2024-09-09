module Api
  module V1
    class FuelTypesController < ApplicationController
      before_action :set_fuel_type, only: [:show, :update, :destroy]

      def index
        @fuel_types = FuelType.all
        render json: @fuel_types
      end

      def show
        render json: @fuel_type
      end

      def create
        @fuel_type = FuelType.new(fuel_type_params)
        if @fuel_type.save
          render json: @fuel_type, status: :created
        else
          render json: @fuel_type.errors, status: :unprocessable_entity
        end
      end

      def update
        if @fuel_type.update(fuel_type_params)
          render json: @fuel_type
        else
          render json: @fuel_type.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @fuel_type.destroy
        head :no_content
      end

      private

      def set_fuel_type
        @fuel_type = FuelType.find(params[:id])
      end

      def fuel_type_params
        params.require(:fuel_type).permit(:name)
      end
    end
  end
end
