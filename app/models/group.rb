# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Group < ApplicationRecord
  include Groupable
  has_many :group_items, dependent: :destroy

  def items
    group_items.map(&:groupable)
  end

  def items_alias
    return if name.blank?
    name.downcase.gsub(/\s/, '_').gsub(/[^a-z_0-9]/, '')
  end

  # The idea is that if you create a group and name it to what it contains
  # you can use that name as an alias for item.
  # For example:
  # library = Group.create(name: :books)
  # library.books == library.items
  # Note:
  # If you use different style naming like:
  # library = Group.create(name: :library)
  # you can better ignore this feature.
  def method_missing(method, *args)
    return items if method.to_s == items_alias
    super
  end

  def respond_to?(method, include_private = false)
    method.to_s == items_alias ||
    super
  end

  def respond_to_missing?(method, include_private = false)
    method.to_s == items_alias ||
    super
  end
end
