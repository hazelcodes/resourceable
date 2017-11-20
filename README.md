# Resourceable
Replaces the need for scaffolded controllers while not restricting the developer.

## Dependencies 

* CanCanCan - loading and authorizing resource
* Ransack   - searching and sorting
* Kaminari  - pagination

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'resourceable'
```
## Usage


### CRUD 
Replaces the need for scaffolded controller code.  You will still need too create the views (for now).

```ruby 
class UsersController < ApplicationController 
  crud permitted: [ # strong params (default to {})
    :email, :password 
    ], 
    cancan: { # cancan options (default is cancan default)
      class_name: User, 
      id_params: :user_id 
    },
    q: :search # ransack url variable (defaults to :q)
end
```

Strong params can be defined in an instance method named `resource_params`

```ruby 
class UsersController < ApplicationController 
  crud

  private 

  def resource_params 
    params.require(:user).permit(:email, :password)
  end
end

```

And of the regular CRUD actions can be done as one normally would.  If you need some custom handling of resource creation, just define it. Resourceable will still handle any actions you haven't defined.

```ruby 
class UsersController < ApplicationController 
  crud permitted: [:email, :password]

  def create 
    if @user.valid?
      @user.save 
      UserMailer.new_user(@user).deliver_now
    else 
      render :new
    end
  end
end

```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
