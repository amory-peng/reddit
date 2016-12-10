# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  value        :integer
#  votable_id   :integer
#  votable_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ActiveRecord::Base
  # validates_uniqueness_of :user_id, :scope => [:votable_id, :votable_type]
  belongs_to :votable, polymorphic: true
  before_save :remove_doppelgaenger

  def remove_doppelgaenger
    vote = Vote.find_by(
    user_id: self.user_id,
    votable_id: self.votable_id,
    votable_type: votable_type
    )
    vote.destroy if vote
  end
end
