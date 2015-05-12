FactoryGirl.define do 
  factory :agent do
    first_name 'John'
    last_name 'Doe'
  end

  factory :lead do
    first_name 'Jane'
    last_name 'Smith'
  end

  factory :deal do
    sequence :property_id do |n|
      n
    end
  end
end