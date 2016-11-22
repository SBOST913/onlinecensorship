# Page
#
# The admin can add pages for every social media platform
#
class Page < ActiveRecord::Base
  ## DB relations
  # belongs_to :social_media_platform
  belongs_to :report
  has_many :pages_questions
  has_many :question_user_submissions
  has_and_belongs_to_many :questions, through: :pages_questions


  # For use search method
  extend Search

  # Validation
  # validates :social_media_platform_id, :presence => true
  translates :message

end
