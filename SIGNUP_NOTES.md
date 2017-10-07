Signup
~ I need a User model
  * This has been done, and I have my and controller
    ~ need signup routes
~ I will get the basics of the signup up and running, and then I will handle the password   
  * secure_password (bcrypt)

1. Sigup routes
  * I'm going to use 'resources :user' for RESTful routes
2. Stub out RESTful conventions in my Users controller
3. Build form in the new user Views
4. Now I need to work on some authentication for password during signup (video review)

* Remember, if you introduce some authentication, be sure to clear db of object (users) instantiated before the authentication.  

5. I want to add some validations for the signup, but this should only validate when a new User is instantiated.
  * I'm going to add bcrypt and has_secure_password now so I can get the password_confirmation
    ~ Need to add password_digest to User attributes
    ~ I will not need validates :password, it comes with basic validations
  * Adding strong params to user controller
  * Also, I want to raise validation errors, and render them to the user.

So, I've run into a problem. Even with validates in place, the user is still allowed to be instantiated (signup).  
    * @user.errors.messages[:username]
Okay, figured out what I was doing, I needed to ask, in my if-statement, if the @user.save, ot try and save it before the if-statement.

I was having a problem with the nav bar and getting the stylistic choice that I wanted. I made some changes, namely, one of them being my routes
  * delete 'session/logout', to: 'sessions#destroy'.  I was leaving off the 'session', in 'session/logout'
