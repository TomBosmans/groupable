module Groupable
  extend ActiveSupport::Concern

  included do
    has_one :group_item, as: :groupable, dependent: :destroy
    has_one :group, through: :group_item

    scope :where_group_id, ->(id) do
      joins(:group_item).where(group_items: { group_id: id })
    end

    scope :where_group_name, ->(name) do
      joins(:group_item, :group).where(group_items: { groups: { name: name } })
    end
  end
end
