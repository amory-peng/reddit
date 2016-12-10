# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text
#  user_id           :integer
#  post_id           :integer
#  parent_comment_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :parent_comment,
    class_name: :Comment,
    primary_key: :id,
    foreign_key: :parent_comment_id
  has_many :child_comments,
    class_name: :Comment,
    primary_key: :id,
    foreign_key: :parent_comment_id

  has_many :votes, as: :votable  
end
