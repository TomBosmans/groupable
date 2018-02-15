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

FactoryBot.define do
  factory :group_item do
    association :group
    # Because a group is groupable we use groups here
    association :groupable, factory: :group
  end
end
