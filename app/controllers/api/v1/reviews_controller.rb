module Api
  module V1
    class ReviewsController < ApplicationController
      before_action :set_review, only: [:show, :update, :destroy]

      def index
        @reviews = Review.all
        render json: @reviews
      end

      def show
        render json: @review
      end

      def create
        @review = Review.new(review_params.merge(user: @current_user))
        if @review.save
          render json: @review, status: :created
        else
          render json: @review.errors, status: :unprocessable_entity
        end
      end

      def update
        if @review.update(review_params)
          render json: @review
        else
          render json: @review.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @review.destroy
        head :no_content
      end

      def by_station
        @reviews = Review.where(station_id: params[:station_id]).includes(:user)
        render json: @reviews
      end

      private

      def set_review
        @review = Review.find(params[:id])
      end

      def review_params
        params.require(:review).permit(:station_id, :rating, :comment)
      end
    end
  end
end
