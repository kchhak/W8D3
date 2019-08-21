# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Response.destroy_all
AnswerChoice.destroy_all
Question.destroy_all
Poll.destroy_all
User.destroy_all

u1 = User.create!(username: 'test')
u2 = User.create!(username: 'devguy')
u3 = User.create!(username: 'bob007')

p1 = Poll.create!(title: 'Color', user_id: u1.id)
p2 = Poll.create!(title: 'Number', user_id: u2.id)
p3 = Poll.create!(title: 'Animal', user_id: u3.id)

q1_1 = Question.create!(poll_id: p1.id, text: 'What is your favorite color?')
q1_2 = Question.create!(poll_id: p1.id, text: 'Least favorite color?')

q2_1 = Question.create!(poll_id: p2.id, text: 'What is your favorite number?')
q2_2 = Question.create!(poll_id: p2.id, text: 'Least favorite number?')

q3_1 = Question.create!(poll_id: p3.id, text: 'What is your favorite animal?')
q3_2 = Question.create!(poll_id: p3.id, text: 'Least favorite animal?')

ac1_1 = AnswerChoice.create!(question_id: q1_1.id, text: 'Red')
ac1_2 = AnswerChoice.create!(question_id: q1_1.id, text: 'Green')
ac1_3 = AnswerChoice.create!(question_id: q1_1.id, text: 'Blue')

r1_1 = Response.create!(user_id: u2.id, choice_id: ac1_1.id)
r1_2 = Response.create!(user_id: u3.id, choice_id: ac1_3.id)