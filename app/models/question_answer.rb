# QuestionAnswer
#
# We save the users answers in the question answers model
#
class QuestionAnswer < ApplicationRecord

  ## DB relations
  belongs_to :uploaded_file
  belongs_to :language
  belongs_to :country
  has_one :question_user_submission
  belongs_to :question
  belongs_to :question_option


  # Validation
  validates :question_id, :question_user_submission_id, :presence => true

end
