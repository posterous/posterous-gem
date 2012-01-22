# Posterous #

## Dependencies ##

  Typhoeus [https://github.com/dbalatero/typhoeus](https://github.com/dbalatero/typhoeus)

## Installation ##

    gem install posterous

## Rails ##

  In your Gemfile:
  
    gem 'posterous'

  Create `config/initializers/posterous.rb`.

```ruby
Posterous.config = {
  'username'  => '<username>',
  'password'  => '<password>',
  'api_token' => '<api_token>'
}
```

## A note on rate limits ##

By default the gem will wait one second per api request. However, if you have a whitelisted 
token, you can pass ```'limit' => false``` in Posterous.config like so:


```ruby
Posterous.config = {
  'username'  => '<username>',
  'password'  => '<password>',
  'api_token' => '<api_token>'
  'limit'     => false
}
```

## Elsewhere ##
    
```ruby
require 'posterous'

Posterous.config = {
  'username'  => '<username>',
  'password'  => '<password>',
  'api_token' => '<api_token>'
}

include Posterous
```


## API ##

## User ##

  **Current user info**
  
    > User.me
    => <#<Posterous::User:0x00000100cacbe0> {:last_activity=>"2011/04/25 20:33:50 -0700",
    :nickname=>"postertester", :lastname=>nil, :id=>1288737, :firstname=>nil, 
    :profile_pic=>"http://posterous.com/images/profile/unknown75.gif"}>
  
  **Favorites**

    > @user = User.me
    > @user.favorites(:page => 1)
    => [<#<Posterous::Post:0x00000100c2c7b0>...] 

  **Subscriptions**

    > @user = User.me
    > @user.subscriptions(:page => 1)
    => [<#<Posterous::Site:0x00000100c2c7b0>...] 

  **Subscription Posts**

    > @user = User.me
    > @user.subscriptions.posts(:page => 1)
    => [<#<Posterous::Post:0x00000100c2c7b0>...] 

## Sites ##

  **Find a primary site**
  
    > Site.primary
    => <#<Posterous::Site:0x00000100c22490> {:header_image=>nil, :name=>"postertester's posterous" ... }>
    
  **Find a Site by its hostname**

    > Site.find('twoism')
    => <#<Posterous::Site:0x00000100c22490> {:header_image=>nil, :name=>"postertester's posterous" ... }>

  **Find all of the current user's Sites**

    > Site.all(:page => 1)
    => [<#<Posterous::Site:0x00000100c22490> {:header_image=>nil, :name=>"postertester's posterous" ... }>]

  **Creating a new Site**

    > @site = Site.create(:hostname => 'superawesome',:is_private => false)
    => <#<Posterous::Site:0x00000100c22490> {:header_image=>nil, :name=>"superawesome's posterous" ... }>

  **Updating a Site**
    
    > @site = Site.primary
    => @site.hostname = 'anotherawesomesite'
    => @site.save

  **Deleting a Site**

    > @site = Site.find('sitetodelete')
    => @site.destroy


## Posts ##

  **Creating Posts**

    > @site = Site.primary
    > @post = @site.posts.create(:title => 'New Post', :body => 'From posterous API', 
    :media => [File.open('/path/to/file')], :autopost => true)
    => <#<Posterous::Post:0x00000100c2c7b0>

  **Updating Posts**
  
    > @post = @site.posts.find(<id>)
    > @post.title = 'Kittens are radical!'
    > @post.save

  **Deleting Posts**
  
    > @post = @site.posts.find(<id>)
    > @post.destroy

  **Retrieving Posts**

    # paginated
    > @site.posts(:page => 1)

    # paginated since a given id
    > @site.posts(:page => 3, :since_id => 123)

## Commenting ##

    > @site = Site.find('someawesomesite')
    > @site.posts.first.comments.create(:body => "Yes, kittens are very
    > radical")

## Liking ##

    > @site = Site.find('someawesomesite')
    > @site.posts.first.likes.create

## Subscribers ##

    > @site = Site.find('someawesomesite')
    > @site.subscribers(:page => 1)

## External Sites / Autopost ##

    > @site.external_sites(:page => 1)
    => [<#<Posterous::ExternalSite:0x00000100c2c7b0>]

## Interactive Console Usage ##

  In your terminal type...
  
    $ posterous
    
  You will then be walked through the setup process. Type `newb` to get some help.
    
    ****************************************************************************************************
    Hi <username>, welcome to the Posterous API Console! For help type `newb`.
    ****************************************************************************************************
    > newb
    
    # Get your primary site
    > Site.primary
    => <#<Posterous::Site:0x000001013e9b88> ... }>

    # Get all your sites
    > Site.all
    => [<#<Posterous::Site:0x000001013e9b88> ... }>]

    # Get any public site
    > Site.find('twoism')
    => <#<Posterous::Site:0x000001013e9b88> ... }>

    # Get some posts
    > s = Site.primary
    > s.posts(:page => 1)
    => [<#<Posterous::Post:0x0000010138ced8> ... }>]

    # Create a post and add a comment to it
    > s = Site.primary
    > post = s.posts.create(:title => 'Woo Hoo!')
     => <#<Posterous::Post:0x00000101398670> 
    > post.comments.create(:body => 'Kittens are radical!')
    => <#<Posterous::Comment:0x0000010135f758> ... }>
    
