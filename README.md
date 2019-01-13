# Dry::Pipeline <a href="https://gitter.im/dry-rb/chat" target="_blank">![Join the chat at https://gitter.im/dry-rb/chat](https://badges.gitter.im/Join%20Chat.svg)</a>

<a href="https://rubygems.org/gems/dry-pipeline" target="_blank">![Gem Version](https://badge.fury.io/rb/dry-pipeline.svg)</a>

# ARCHIVED

Ruby 2.6 introduced Proc composition with `>>` and `<<`, that's essentially rendered this project obsolete.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dry-pipeline'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:
```sh
$ gem install dry-pipeline
```

## Usage

```ruby
USERS = []
User = Struct.new(:id, :first_name, :last_name, :email)

transform_user_attributes = Dry::Pipeline.new do |user_attributes|
  allowed_keys = [:id, :first_name, :last_name, :email]

  user_attributes.each_with_object({}) do |(key, value), hash|
    next unless allowed_keys.include?(key.to_sym)
    hash[key.to_sym] = value
  end
end

validate_user_attributes = Dry::Pipeline.new do |user_attributes|
  required_keys = [:first_name, :last_name, :email]

  if (required_keys - user_attributes.keys).empty?
    user_attributes
  else
    raise ':first_name, :last_name and :email must be present'
  end
end

create_user = Dry::Pipeline.new do |user_attributes|
  User.new(
    USERS.length.next, *user_attributes.values_at(:first_name, :last_name, :email)
  ).tap { |user| USERS << user }
end

(transform_user_attributes >> validate_user_attributes >> create_user)[
  first_name: 'Jane',
  last_name: 'Doe',
  email: 'jane.doe@gmail.com'
]
# => #<struct User id=1, first_name="Jane", last_name="Doe", email="jane.doe@gmail.com">
```
