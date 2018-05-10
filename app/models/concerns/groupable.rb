module Groupable
  extend ActiveSupport::Concern

  included do
    has_one :group_item, as: :groupable, dependent: :destroy
    has_one :group, through: :group_item

    scope :where_group_id, ->(id) do
      joins(:group_item).where(group_items: { group_id: id })
    end

    scope :where_group_name, ->(name) do
      joins(:group_item, :group).where("#{group_table}" => { name: name })
    end

    private

    # Group is also groupable. ActiveRecord gets confused with the join so we
    # need to fix it ourselves.
    def self.group_table
      return 'groups_groups' if table_name == 'groups'
      'groups'
    end
  end
end
