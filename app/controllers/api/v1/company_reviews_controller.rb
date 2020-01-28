module Api
  module V1
    class CompanyReviewsController < ApplicationController
      before_action :authorize_access_request!, except: [:show, :index]
      before_action :set_company_review, only: [:show, :update, :destroy]

      # GET /company_reviews
      def index
        @company_reviews = CompanyReview.all

        render json: @company_reviews
      end

      # GET /company_reviews/1
      def show
        render json: @company_review
      end

      # POST /company_reviews
      def create
        @company_review = CompanyReview.new(company_review_params)
        @company_review.user = current_user

        if @company_review.save
          render json: @company_review, status: :created, location: api_v1_company_review_url(@company_review)
        else
          render json: @company_review.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /company_reviews/1
      def update
        if @company_review.update(company_review_params)
          render json: @company_review
        else
          render json: @company_review.errors, status: :unprocessable_entity
        end
      end

      # DELETE /company_reviews/1
      def destroy
        @company_review.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_company_review
          @company_review = CompanyReview.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def company_review_params
          params.require(:company_review).permit(:company_id, :user_id, :review, :rating, :user_id)
        end
    end
  end
end

