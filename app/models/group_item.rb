# == Schema Information
#
# Table name: group_items
#
#  id             :integer          not null, primary key
#  group_id       :integer
#  groupable_type :string
#  groupable_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'concerns/groupable'

class GroupItem < ApplicationRecord
  belongs_to :group
  belongs_to :groupable, polymorphic: true, dependent: :destroy

  validates :group_id, presence: true
  validates :groupable_id, presence: true
end
