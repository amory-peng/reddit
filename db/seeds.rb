random_names = []
until random_names.length == 20
  name = Faker::Pokemon.name
  random_names << name unless random_names.include?(name)
end

#Users
20.times do |i|
  username = random_names[i]
  password = "password"
  User.create(username: username, password: password)
end

#Subs
20.times do |i|
  description = Faker::Hipster.sentence
  title = Faker::ChuckNorris.fact
  user_id = (1..20).to_a.sample
  Sub.create(
    description: description,
    title: title,
    user_id: user_id
  )
end

#Posts
200.times do |i|
  title = Faker::Company.catch_phrase
  url = Faker::Internet.url('example.com')
  content =Faker::Lorem.paragraph
  user_id = (1..20).to_a.sample
  sub_ids = (1..20).to_a.shuffle.take(rand(3..9))
  Post.create(
    title: title,
    url: url,
    content: content,
    user_id: user_id,
    sub_ids: sub_ids
  )
end

#Votes
20.times do |i|
  Post.find(i+1).votes << Vote.create(value: [1,-1].sample, user_id: i)
end
