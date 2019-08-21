# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  poll_id    :integer          not null
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  validates :text, presence: true

  has_many :answer_choices,
    class_name: :AnswerChoice,
    foreign_key: :question_id

  belongs_to :poll,
    class_name: :Poll,
    foreign_key: :poll_id

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def n_plus_1_results
    answers = {}
    answer_choices.each do |answer|
      answers[answer.text] = answer.responses.count
    end
    answers
  end

  def results_2
    c = answer_choices.includes(:responses)

    answers = {}
    c.each do |answer|
      answers[answer.text] = answer.responses.length
    end
    answers
  end

  def results
    SELECT
      answer_choices.*, COUNT(responses.*)
    FROM
      answer_choices
    LEFT OUTER JOIN
      responses ON id = choice_id
    WHERE
      answer_choices.question_id = self.id
    GROUP BY

  end

end
