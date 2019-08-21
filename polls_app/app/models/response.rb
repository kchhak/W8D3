# == Schema Information
#
# Table name: responses
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  choice_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Response < ApplicationRecord
  validate :not_duplicate_response, :not_poll_author

  belongs_to :respondent,
    class_name: :User,
    foreign_key: :user_id

  belongs_to :answer_choice,
    class_name: :AnswerChoice,
    foreign_key: :choice_id

  has_one :question,
    through: :answer_choice,
    source: :question

  
  def sibling_responses
    question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.user_id)
  end

  def not_duplicate_response
    if respondent_already_answered?
      errors[:user_id] << "already answered!"
    end
  end

  def not_poll_author
    if question.poll.author.id == self.user_id
      errors[:user_id] << "is the author!"
    end 
  end

end
