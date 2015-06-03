# 10.times do
#   User.create(
#     username: Faker::Internet.user_name,
#     password: Faker::Internet.password(4)
#     )
# end

# 1.times do
#   Profile.create(
#     name: Faker::Name.name,
#     email: Faker::Internet.email,
#     dob: Date.today - rand(15..40)*365,
#     user_id: 16
#     # user_id: User.pluck(:id).sample
#     )
# end

# 500.times do
#   Status.create(
#     status_desc: Faker::Lorem.sentence,
#     user_id: User.pluck(:id).sample
#     )
# end

# 500.times do
#   Comment.create(
#     comment_desc: Faker::Lorem.sentence,
#     user_id: User.pluck(:id).sample,
#     status_id: Status.pluck(:id).sample
#     )
# end

# 500.times do
#   Like.create(
#     user_id: User.pluck(:id).sample,
#     status_id: Status.pluck(:id).sample
#     )
# end

5000.times do
  Tag.create(
    tag_desc: Faker::Lorem.word,
    status_id: Status.pluck(:id).sample,
    user_id: User.pluck(:id).sample
    )
end

