namespace :db do
    desc "Fill database with sample data"
    task populate: :environment do
        User.create!(name: "User",
        email: "four@railstutorial.org",
        address: "Kumasi",
        phone: 5202329871,
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
        users =User.all()
        5.times do 
            content =Faker::Lorem.sentence(5)
            users.each { |user| user.microposts.create!(content: content) }
        end
    end
end