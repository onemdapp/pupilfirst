require_relative 'helper'

puts 'Seeding founders'

# 3 random founders for sv.co
founders_list = [
  ['someone@sv.co', 'Some One', 20.years.ago, Founder::GENDER_MALE, 9876543210],
  ['thedude@sv.co', 'Big Lebowski', 40.years.ago, Founder::GENDER_MALE, 9000000000],
  ['thirdgal@sv.co', 'Gal Third', 30.years.ago, Founder::GENDER_FEMALE, 9898989898]
]

# 5 more founders for avengers
founders_list += [
  ['ultron@avengers.co', 'Henry Jonathan Pym', 40.years.ago, Founder::GENDER_MALE, 9111111111],
  ['wasp@avengers.co', 'Janet Dyne', 25.years.ago, Founder::GENDER_FEMALE, 9222222222],
  ['ironman@avengers.co', 'Anthony Edward Tony Stark', 40.years.ago, Founder::GENDER_MALE, 9333333333],
  ['hulk@avengers.co', 'Robert Banner', 35.years.ago, Founder::GENDER_MALE, 9444444444],
  ['thor@avengers.co', 'Thor Odinson', 30.years.ago, Founder::GENDER_MALE, 9555555555]
]

image_path = File.absolute_path(Rails.root.join('spec', 'support', 'uploads', 'users', 'college_id.jpg'))

founders_list.each do |email, name, born_on, gender, phone|
  # Don't recreate entries.
  next if Founder.find_by(email: email).present?

  user = User.where(email: email).first_or_create!

  Founder.create!(
    email: email,
    user: user,
    name: name,
    born_on: born_on,
    gender: gender,
    phone: phone,
    roles: Founder.valid_roles.sample([1, 2].sample),
    communication_address: [Faker::Address.street_address, Faker::Address.city, Faker::Address.zip].join("\n"),
    identification_proof: File.open(image_path)
  )
end
