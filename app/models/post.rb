# Post
#
# The admin can add posts for every category
#
class Post < ActiveRecord::Base

  ## DB relations
  belongs_to :person
  belongs_to :category
  has_and_belongs_to_many :posts_themes, through: :posts_posts_themes
  has_and_belongs_to_many :social_media_platforms, through: :posts_social_media_platforms


  # For use search method
  extend Search

  # For gem FriendlyId
  extend FriendlyId
  friendly_id :title, use: :slugged

  # change the id order
  default_scope { order("id DESC") }

  # Define attachments
  ## The post photo # min-height: 490px
  has_attached_file :photo, :styles => { :thumb => '375x490#' },
                           :default_url => "/:style_default_post_image.jpg"
  ## Attachments Validation
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :photo, :less_than => 1.megabyte

  ## The side image validation
  has_attached_file :side_image,
                           :default_url => "/default_post_side_image.jpg"

  validates_attachment_content_type :side_image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :side_image, :less_than => 1.megabyte

  ## Analysis downloadable pdf
  has_attached_file :pdf

  ## Attachments Validation
  validates_attachment_content_type :pdf, content_type: ['image/jpeg', 'image/png', 'application/pdf']
  validates_attachment_size :pdf, :less_than => 100.megabyte

  # Validation
  validates :title,:intro,:category_id, :presence => true

end
