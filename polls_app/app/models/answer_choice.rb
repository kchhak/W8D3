# == Schema Information
#
# Table name: answer_choices
#
#  id          :bigint           not null, primary key
#  question_id :integer          not null
#  text        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class AnswerChoice < ApplicationRecord
  validates :text, presence: true

  belongs_to :question,
    class_name: :Question,
    foreign_key: :question_id

  has_many :responses,
    class_name: :Response,
    foreign_key: :choice_id
end
