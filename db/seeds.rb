# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.logger = Logger.new(STDOUT)

require 'json'

connection = Faraday.new "https://script.google.com" do |conn|
  conn.use FaradayMiddleware::FollowRedirects
  conn.adapter :net_http
end

response = connection.get '/macros/s/AKfycbxsUPPD9kLKH7cLra9-4N8q_smqVufg3uaCpR9NaekfT-fGJQCH/exec'
json_data = JSON.parse(response.body)

puts json_data

# records = []
json_data['tables']['users'].each do |row|
    User.create(
        id: row['id'],
        email: row['email'],
        password: row['password'],
        password_confirmation: row['password']
    )
    # records << User.new(
    #     id: row['id'],
    #     email: row['email'],
    #     password: row['password']
    # )
end
# User.import records

records = []
json_data['tables']['categories'].each do |row|
    records << Category.new(
        id: row['id'],
        name: row['name']
    )
end
Category.import records

records = []
json_data['tables']['posts'].each do |row|
    records << Post.new(
        id: row['id'],
        user_id: row['user_id'],
        aword: row['aword']
    )
end
Post.import records

records = []
json_data['tables']['tasks'].each do |row|
    records << Task.new(
        id: row['id'],
        time: row['time'],
        post_id: row['post'],
        category_id: row['category']
    )
end
Task.import records
