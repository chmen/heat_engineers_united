require 'test_helper'

class CompanyReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company_review = company_reviews(:one)
  end

  test "should get index" do
    get company_reviews_url, as: :json
    assert_response :success
  end

  test "should create company_review" do
    assert_difference('CompanyReview.count') do
      post company_reviews_url, params: { company_review: { company_id: @company_review.company_id, rating: @company_review.rating, review: @company_review.review, user_id: @company_review.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show company_review" do
    get company_review_url(@company_review), as: :json
    assert_response :success
  end

  test "should update company_review" do
    patch company_review_url(@company_review), params: { company_review: { company_id: @company_review.company_id, rating: @company_review.rating, review: @company_review.review, user_id: @company_review.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy company_review" do
    assert_difference('CompanyReview.count', -1) do
      delete company_review_url(@company_review), as: :json
    end

    assert_response 204
  end
end
