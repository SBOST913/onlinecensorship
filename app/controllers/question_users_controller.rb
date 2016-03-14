class QuestionUsersController < ApplicationController
  before_action :authenticate_user!
  layout 'backend'

  def index
    respond_to do |format|
      # Using it in the backEnd to allow the admin to show and navigate all the model data
      format.html {
        results=QuestionUser.search(params[:search],'email')
        @question_users=results.page(params[:page])
        @count=results.count
        @social_media_platforms = SocialMediaPlatform.all
      }

      # Using it to export excel file
      format.xls {

        # Get the platform
        @platform = SocialMediaPlatform.where(:id=>params[:platform]).first

        @question_users = []
        @questions = []
        @question_user_submissions = []
        # Get the platform pages
        @platform.pages.each do |page|
          # Get the users
          if page.question_user_submissions.present?
            page.question_user_submissions.each do |submission|
              if submission.question_user.present?
                @question_user_submissions << submission unless @question_user_submissions.include?(submission)
                @question_users << submission.question_user unless @question_users.include?(submission.question_user)
              end
            end
          end

          # Get the questions
          if page.pages_questions.present?
            page.pages_questions.each do |pages_question|
              if pages_question.question.present?
                @questions << pages_question.question unless @questions.include?(pages_question.question)
              end
            end
          end
        end
      }
    end
  end

  def show
    # an iteration pattern takes place in show.html.erb populating many instance
    # variables
    @question_user = QuestionUser.find(params[:id])
  end

  private

    def question_user_params
      params.require(:question_user).permit(:inform_platform, :email)
    end
end
