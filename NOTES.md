This is a dummy app.  I will used this, as a review and build my project app, as a sandbox to test ideas and concepts.  

So, I wanted to try out the Rspec in the 'ActiveRecord Models and Rails' lesson, to determine whether I want to include, at some limited level, in my project app.
  * I've updated my gem file: 'gem 'rspec-rails', '~> 3.0''
  * ran 'bundle install'
  * ran 'rails g rspec:install'
  * created a file: spec/models/project_spec.rb
   ~ and included:
      require 'rails_helper'

        describe Project do
          it 'can be created' do
            #project = Project.create!(title: "My title", description: "The post description")
            project = Project.create!(title: "My title")
            expect(project).to be_valid
          end
        end
  * Then ran: 'bundle exec rspec'

Okay, good first run with rspec. Before I finish for the day, lets see if it interferes with rails test suite.  
  * Include:
      test "should not save article without title" do
        article = Article.new
        assert_not article.save, "Saved the article without a title"
      end

    in project_test.rb
  * run: rails test test/models/project_test.rb

That all works really well.  That's enough review of rspec for the day.  Continue on building out app.  

Practice with a simple association.  User has_many :projects, and a Project belongs_to :User
  * User
    has_many :projects
  * Project
    belongs_to :user ~> migration needs foreign key: user_id
Now, do I user rails g migration, or rails g resource User
After testing these models and their associations in rails console,
This association work ~> @user.projects #=> an [],
  new_project = user.projects.build(title: 'project title')
  new_project.save
  new_project # => user_id: 1
Now, working on authentication, login/logout,
  * Create Sessions controller
  * RESTful routes
  * Views
    ~ I want the user to be greeted with their username
    ~ If they are logged in, they will have a logout option
    ~ If they are not, they will have a login/signup option
So, take a step back.  I created a Sessions controller, and wired up the correct routes.  I will work on the form_for, to get a user signed in.  
  * However, I may need to pause, go back and do signup first.  
  ** Going to change routes from 'users/login' to just login
  ** So, I can't use form_for @user, because this creates a post request for controller: Users, and action: new.  
  ** I'm going to use for_tag.  
So, I have basic login functionality, and it returns to the root. I'd like to greet the user with their username, provided they are logged in.  
  * I think this will be my first helper, so I can abstract away the logic from the root view.  
  * Also, it just dawned on me, I need to make a logout link
    ~ So, I was reminded that I can use <%= link_to login_path %>, <%= link_to logout_path, method: 'delete' %>, links, but I have to make sure I change the login route to 'delete'
So, after lunch, take a step back, and review what I've done.
  * Change all session[:username] to session[:user_id]
I need to work on getting User registered or signed up.  When I convert this over to the dyi_app, do the registration first!!!  

- For tomorrow, I'm going to finish the signup process (Avi's video), I'm pretty close to being done.  
- Convert to dyi_app
- Move these links (signin/signup) into nav background
- CSS template
- Start looking at Projects, Categories and Materials.  

Added password_confirmation to my signup views, model and strong params, in the User controller.  

So, I've the signup working. I am going to refactor a bit to get signin/signout, signup in the nav bar.  
  * I want DYI ~ to be root
  * I want a signin or sigup option for user if they are not logged in
  * Okay, at this point I do want to make a current_user method.  
Must be tired. After wrestling with signin and signout in the nav and sessions controller, I think I got it working pretty well

I'm going to create the Project, Category and ProjectCategory migrations, models and when necessary, controllers.  

It seems, I have the associations wired up appropriately.  
