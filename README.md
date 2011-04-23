# Posterous #

## Installation ##

    gem install posterous
    
## Basic Usage ##
    
    require 'posterous'
    
    Posterous.config = {
      'username' => <username>,
      'password' => <password>,
      'api_token' => '<api_token>'
    }
    
    include Posterous
    
    ### Sites ###
    p Site.all
    p Site.primary
    p Site.find('twoism')
    
    ### Posts ###
    p Site.primary.posts
    p Site.primary.posts.create(:title => 'New Post', :body => 'From posterous API', :media => [File.open('/path/to/file')])

    
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
    