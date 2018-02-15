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

require 'test_helper'

describe Group do
  include GroupableBook

  describe '#destroy' do
    it 'responds to destroy' do
      assert library.respond_to? :destroy
    end

    it 'destroys the group' do
      library.destroy
      assert library.destroyed?
    end

    it 'destroys the group items' do
      4.times { Book.create(group: library) }
      library.destroy
      assert library.group_items.empty?
    end
  end

  describe '#name' do
    it 'responds to name' do
      assert library.respond_to? :name
    end
  end

  describe '#description' do
    it 'responds to description' do
      assert library.respond_to? :description
    end
  end

  describe '#items' do
    it 'responds to items' do
      assert library.respond_to? :items
    end
  end

  describe '#items_alias' do
    it 'responds to items_alias' do
      assert library.respond_to? :items_alias
    end

    it 'it only returns a string with a-z, underscores and numbers' do
      library.name = '}<-/sPec??iaL)*)" bo#&%^oK--s+='
      assert library.items_alias == 'special_books'
    end

    it 'replaces spaces with underscore' do
      library.name = 'hallo world'
      assert library.items_alias == 'hallo_world'
    end

    it 'allows numbers' do
      library.name = 'books2'
      assert library.items_alias == 'books2'
    end
  end

  describe '#group_items' do
    it 'responds to group_items' do
      assert library.respond_to? :group_items
    end
  end

  describe '#books' do
    it 'responds to books' do
      assert library.respond_to? :books
    end

    it 'does not respond to a random name' do
      assert_not library.respond_to? :articles
    end

    it 'returns the same as items' do
      4.times { Book.create(group: library) }
      assert library.items == library.books
    end
  end
end
