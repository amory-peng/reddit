# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  belongs_to :owner, class_name: :User, foreign_key: :user_id

  has_many :postsubs, inverse_of: :post
  has_many :subs, through: :postsubs

  has_many :comments

  has_many :votes, as: :votable

  extend FriendlyId
  friendly_id :title, use: :slugged

  def comments_by_parent_id
    hash = Hash.new()
    self.comments.each do |comment|
      hash[comment.parent_comment_id] = [] if hash[comment.parent_comment_id].nil?
      hash[comment.parent_comment_id] << comment
    end
    hash
  end
end
