# To test the groupable concern independently we use a tmp class Book that has
# the Groupable module included and has an alias_attribute library for group.
# For more details check test/shared/groupable_book.rb

require 'test_helper'

describe Groupable do
  include GroupableBook

  describe '.create' do
    it 'responds to create' do
      assert Book.respond_to? :create
    end

    it 'does not need a group' do
      # Why has `Book.create` library as group?
      book = Book.create(group: nil)
      assert_nil book.group
    end

    it 'can have a group' do
      book = Book.create(group: library)
      assert_equal book.library, library
    end
  end

  describe '.where_group_id' do
    # Need to call book_1, book_2 before the query, else they are not created.
    let(:book_ids) { [book_1.id, book_2.id] }
    let(:library_book_ids) do
      Book.order(:id).where_group_id(library.id).pluck(:id)
    end

    it 'responds to where_group_id' do
      assert Book.respond_to? :where_group_id
    end

    it 'returns all books where group equals the id' do
      assert_equal book_ids, library_book_ids
    end

    it 'does not return other books' do
      library_2 = FactoryBot.create(:group)
      book_3 = Book.create(group: library_2)
      book_4 = Book.create
      assert_equal book_ids, library_book_ids
    end

    it 'can be empty' do
      library_2 = FactoryBot.create(:group)
      assert Book.where_group_id(library_2.id).empty?
    end
  end

  describe '.where_group_name' do
    # Need to call book_1, book_2 before the query, else they are not created.

    it 'responds to where_group_name' do
      assert Book.respond_to? :where_group_name
    end

    it 'returns all books where group equals the name' do
      group = FactoryBot.create(:group, name: 'group1')
      Book.create(group: group)
      Book.create(group: group)

      expected_ids = group.items.pluck(:id).sort
      assert_equal expected_ids,
                   Book.where_group_name('group1').pluck(:id).sort
    end

    it 'does not return other books' do
      group_1 = FactoryBot.create(:group, name: 'group1')
      group_2 = FactoryBot.create(:group, name: 'group2')
      Book.create(group: group_1)
      Book.create(group: group_1)
      Book.create(group: group_2)
      Book.create

      expected_ids = group_2.items.pluck(:id).sort
      assert_equal expected_ids,
                   Book.where_group_name('group2').pluck(:id).sort
    end

    it 'does not return doubles if multiple groups have the same name' do
      group_1 = FactoryBot.create(:group, name: 'group_name')
      group_2 = FactoryBot.create(:group, name: 'group_name')
      Book.create(group: group_1)
      Book.create(group: group_1)
      Book.create(group: group_2)
      Book.create

      group_1_item_ids = group_1.items.pluck(:id)
      group_2_item_ids = group_2.items.pluck(:id)
      expected_ids = (group_1_item_ids + group_2_item_ids).uniq.sort

      assert_equal expected_ids,
                   Book.where_group_name('group_name').pluck(:id).sort
    end

    it 'can be empty' do
      library_2 = FactoryBot.create(:group, name: 'movies')
      assert Book.where_group_id(library_2.name).empty?
    end

    it 'works with Group aswell' do
      group = FactoryBot.create(:group, name: 'group of groups')
      3.times { FactoryBot.create(:group, group: group) }

      expected_ids = group.items.pluck(:id).sort
      assert_equal expected_ids,
                   Group.where_group_name('group of groups').pluck(:id).sort
    end
  end

  describe '#group' do
    it 'responds to group' do
      assert book_1.respond_to? :group
    end

    it 'returns the group' do
      assert_equal book_1.group, library
    end
  end

  describe '#library' do
    it 'responds to library' do
      assert book_1.respond_to? :library
    end

    it 'returns the group' do
      assert_equal book_1.library, library
    end
  end

  describe '#group_item' do
    it 'responds to group_item' do
      assert book_1.respond_to? :group_item
    end

    it 'has a group_item' do
      assert book_1.group_item.present?
    end
  end
end
