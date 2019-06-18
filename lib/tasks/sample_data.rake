namespace :db do
    desc "Fill database with sample data"
    task populate: :environment do
        User.create!(name: "Example User",
        email: "example@railstutorial.org",
        password: "foobar",
        password_confirm: "foobar")
        99.times do |n|
            name = Faker::Name.name
            email = "example-#{n+1}@railstutorial.org"
            address="Kumasi"
            phone=5555555555
            password = "password"
            User.create!(name: name,email: email,address: address,phone: phone ,password: password,password_confirm: password)
        end
    end
end