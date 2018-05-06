# This will setup everything you need to write isolated tests with groupable items.
# It will create a tmp db table before the test runs and drop it when it's done.

module GroupableBook
  extend ActiveSupport::Concern

  included do
    let(:library) { FactoryBot.create(:group, name: :books) }
    let(:book_1) {  Book.create(group: library) }
    let(:book_2) { Book.create(group: library) }

    before(:all) { create_table }
    after(:all) { drop_table }
  end
end

class Book < ApplicationRecord
  include Groupable
  alias_attribute :library, :group
  self.table_name = 'tmp_books'
end

def create_table
  ActiveRecord::Base.connection.create_table :tmp_books
end

def drop_table
  ActiveRecord::Base.connection.drop_table :tmp_books
end
