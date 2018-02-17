# Groupable
When working on my hobby project [Magnus](https://github.com/TomBosmans/magnus) I needed to group articles. While making my article_group I realised that every time I made this kind of groups they always where the same. They had a title and a description and had multiple items. Groupable is my attempt to make this a bit more dry.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'groupable', git: 'https://github.com/TomBosmans/groupable.git', tag: '1.0'
```

And then execute:
```bash
$ bundle install
$ rails groupable_engine:install:migrations
$ rails db:migrate
```

## Usage
```ruby
class Book < ApplicationRecord
  include Groupable
  alias_attribute :library, :group
end

library = Group.create(name: 'Books', description: 'group of books')

there_and_back_again = Book.create(group: library)
the_lord_of_the_rings = Book.create(group: library)
the_silmarillion = Book.create(group: library)

library.items # => [#<Book id: 1>, #<Book id: 2>, #<Book id: 3>]
there_and_back_again.group # => #<Group id: 1, name: "Books", description: "group of books", ...">
```

### Fun stuff
You can also use the group name as an alias for items, in this case 'books'. Altough I consider this more a gimmick, it might be nice to use.
```ruby
library.books # => [#<Book id: 1>, #<Book id: 2>, #<Book id: 3>]
there_and_back_again.library # => #<Group id: 1, name: "Books", description: "group of books", ...">
```

Group can also be part of a group, and a group does not care about what it contains:
```ruby
library = Group.create(name: 'Genres', description: 'group of books')
fantasy = Group.create(name: 'Books', description: 'Fantasy books', group: library)
scifi = Group.create(name: 'Books', description: 'Scifi books', group: library)

there_and_back_again = Book.create(group: fantasy)
the_lord_of_the_rings = Book.create(group: fantasy)
the_silmarillion = Book.create(group: fantasy)
burning_of_prospero = Book.create(group: scifi)

library.genres
# => [#<Group id: 2, name: "Books", description: "Fantasy books", ...>, #<Group id: 3, name: "Books", description: "Scifi books", ...>]

fantasy.books # [#<Book id: 1>, #<Book id: 2>, #<Book id: 3>]
scifi .books # [#<Book id: 4>]
```
So the structure of library is:
* Library (Group)
** fantasy (Group)
*** there and back again (Book)
*** the silmarillion (Book)
*** the lord of the rings (Book)
** scifi (Group)
*** burning of prospero (Book)

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
