FactoryGirl.define do
  factory :order do
    total_charge "9.99"
    number_of_items "MyString"
    special_instructions "MyString"
    shipping_reference "MyString"
    estimated_weight "MyString"
    signature_requirement 1
    user nil
  end
end
