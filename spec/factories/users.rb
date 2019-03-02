FactoryBot.define do 
    factory :user do 
        name { Faker::Name.unique.name }
        password {'starwars'}
    end
end