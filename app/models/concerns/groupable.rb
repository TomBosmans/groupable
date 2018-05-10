module Groupable
  extend ActiveSupport::Concern

  included do
    has_one :group_item, as: :groupable, dependent: :destroy
    has_one :group, through: :group_item

    scope :where_group_id,
          ->(id) { joins(:group).where(groups: { id: id }) }
    scope :where_group_name,
          ->(name) { joins(:group).where(groups: { name: name }) }
  end
end
