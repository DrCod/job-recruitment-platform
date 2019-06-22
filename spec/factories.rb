FactoryBot.define do
  factory :micropost do
    content { "Lorem ipsum" }
    user
  end

    factory :user do
        sequence(:name) { |n| "Person #{n}" }
        sequence(:email) { |n| "person #{n}@example.com"}
        password {"foobar"}
        password_confirm {"foobar"}
        address {"Zealand"}
        phone{0000000000}
        

        factory :admin do
            admin {true}
        end
    end
end 