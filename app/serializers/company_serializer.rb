class CompanySerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attribue :rating do |company|
    reviews = company.company_reviews

    reviews.pluck(:rating).reduce(:+).to_f/reviews.size
  end
end
