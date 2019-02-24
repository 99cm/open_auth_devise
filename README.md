Open Auth (Devise)
=====================

Provides authentication services for [Open][1], using the Devise gem, in addition, supports to configure omniauthable.

Installation
------------

Just add this extension to your Gemfile with this line:

  ```ruby
  gem 'open_auth_devise', github: '99cm/open_auth_devise', branch: 'master'
  ```

Then install the gem using Bundler:
  ```ruby
  bundle install
  ```

After that's done, you can install and run the necessary migrations, then seed the database:

```shell
bundle exec rake open_auth:install:migrations
bundle exec rake db:migrate
bundle exec rake db:seed
```

### Default Username/Password

As part of running the above installation steps, you will be asked to set an admin email/password combination. The default values are `admin@example.com` and 'test123', respectively.

### Confirmable

To enable Devise's Confirmable module, which will send the user an email with a link to confirm their account, you must do the following:

* Add this line to an initializer in your Rails project (typically `config/initializers/spree.rb`):
```ruby
Spree::Auth::Config[:confirmable] = true
```

* Add a Devise initializer to your Rails project (typically `config/initializers/devise.rb`):
```ruby
Devise.setup do |config|
  # Required so users don't lose their carts when they need to confirm.
  config.allow_unconfirmed_access_for = 1.days

  # Add any other devise configurations here, as they will override the defaults provided by open_auth_devise.
end
```

### Sign out after password change

To disable signout after password change you must add this line to an initializer in your Rails project (typically `config/initializers/spree.rb`):

```ruby
Spree::Auth::Config[:signout_after_password_change] = false
```

## Using in an existing Rails application

If you are installing Open inside of a host application in which you want your own permission setup, you can do this using open_auth_devise's register_ability method.

First create your own CanCan Ability class following the CanCan documentation.

For example: app/models/super_ability.rb

```ruby
class SuperAbility
  include CanCan::Ability

  def initialize user
    if user.is? "Superman"
      can :stop, Bullet
    end
  end
end
```

Then register your class in your spree initializer: config/initializers/spree.rb
```ruby
Spree::Ability.register_ability(SuperAbilities)
```

Inside of your host application you can then use CanCan like you normally would.
```erb
<% if can? :stop, Bullet %>
  ...
<% end %>
```
## Testing

You need to do a quick one-time creation of a test application and then you can use it to run the tests.

    bundle exec rake test_app

Then run the rspec tests.

    bundle exec rspec

---

Copyright (c) 2019 [Leo Wang][3] and other [contributors][2]. released under the [New BSD License][3]

[1]: https://github.com/99cm/open
[2]: https://github.com/99cm/open_auth_devise/graphs/contributors
[3]: https://github.com/99cm/open_auth_device/blob/master/LICENSE.md