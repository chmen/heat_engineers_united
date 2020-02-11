module Api
  module V1
    class CompaniesController < ApplicationController
      before_action :authorize_access_request!, except: [:show, :index]
      before_action :set_company, only: [:show, :update, :destroy]

      def index
        @companies = Company.all

        serialized_string = CompanySerializer.new(@companies).serialized_json

        render json: serialized_string
      end

      def show
        render json: @company
      end

      def create
        @company = Company.new(company_params)

        if @company.save
          render json: @company, status: :created, location:  api_v1_companies_url(@company)
        else
          render json: @company.errors, status: :unprocessable_entity
        end
      end

      def update
        if @company.update(company_params)
          render json: @company
        else
          render json: @company.errors, status: :unprocessable_entity
        end

      end

      def destroy
        @company.destroy
      end

      private

      def set_company
        @company = Company.find(params[:id])
      end

      def company_params
        params.fetch(:company, ).permit(:name)
      end
    end
  end
end
