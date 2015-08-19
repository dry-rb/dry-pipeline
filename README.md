# Dry::Pipeline <a href="https://gitter.im/dryrb/chat" target="_blank">![Join the chat at https://gitter.im/dryrb/chat](https://badges.gitter.im/Join%20Chat.svg)</a>

<a href="https://rubygems.org/gems/dry-pipeline" target="_blank">![Gem Version](https://badge.fury.io/rb/dry-pipeline.svg)</a>
<a href="https://travis-ci.org/dryrb/dry-pipeline" target="_blank">![Build Status](https://travis-ci.org/dryrb/dry-pipeline.svg?branch=master)</a>
<a href="https://gemnasium.com/dryrb/dry-pipeline" target="_blank">![Dependency Status](https://gemnasium.com/dryrb/dry-pipeline.svg)</a>
<a href="https://codeclimate.com/github/dryrb/dry-pipeline" target="_blank">![Code Climate](https://codeclimate.com/github/dryrb/dry-pipeline/badges/gpa.svg)</a>
<a href="http://inch-ci.org/github/dryrb/dry-pipeline" target="_blank">![Documentation Status](http://inch-ci.org/github/dryrb/dry-pipeline.svg?branch=master&style=flat)</a>

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dryrb/dry-pipeline.

