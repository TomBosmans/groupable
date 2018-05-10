module Groupable
  extend ActiveSupport::Concern

  included do
    has_one :group_item, as: :groupable, dependent: :destroy
    has_one :group, through: :group_item

    scope :where_group, ->(group_id) { joins(:group_item).where(group_items: { group_id: group_id }) }
  end
end
