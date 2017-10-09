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
So, I got the categories to print out.  I now want to link them to ?
  * I think I need to link to a Category show page, and this show page will list out all the projects associated with that category.  
    ~ For instance:
      * 'auto repair' could list out
        ~ 'Change your air filter'
        ~ 'Change a tire'
        ~ 'Change the oil'
        ~ 'Replace coolant fluid'
  * So to do this I need a Category show page.  
  * Also, I should now starting thinking about, and looking at, nested forms and routes.  
    ~ Read 'Routing and nested Resources'
    ~ Nested forms
    ~ Assigning attributes
      * maybe it should be category/1/projects?
        ~ categories#projects_index?
example ~ replace author with category and category with projects, I thinking

# config/routes.rb

  get 'authors/:id/posts', to: 'authors#posts_index'
  get 'authors/:id/posts/:post_id', to: 'authors#post'

# authors controller
    def posts_index
        @author = Author.find(params[:id])
        @posts = @author.posts
        render template: 'posts/index'
      end

      def post
        @author = Author.find(params[:id])

        # Note that because ids are unique by table we can go directly to
        # Post.find — no need for @author.posts.find...
        @post = Post.find(params[:post_id])
        render template: 'posts/show'
      end

      # config/routes.rb

  Rails.application.routes.draw do

    resources :authors, only: [:show] do
      # nested resource for posts
      resources :posts, only: [:show, :index]
    end

    resources :posts, only: [:index, :show, :new, :create, :edit, :update]

    root 'posts#index'
  end

  # app/controllers/posts_controller.rb

    def index
      if params[:author_id]
        @posts = Author.find(params[:author_id]).posts
      else
        @posts = Post.all
      end
    end

    def show
      @post = Post.find(params[:id])
    end

Okay, so I was unable to persist Project object to the db, and so I dropped and deleted the db. Going to start with project, and build out from there, testing each object along the way.  
  * Learn something helpful: if an object won't persist, .save! will give an error.  

So, my problem was that "ActiveRecord::RecordInvalid: Validation failed: User must exist", and once I got rid of validations, on the User model, the project would now persist.  
  * Now need to figure out how to fix that.  
  * Github response: "If you're on Rails 5, you'll need to update your user association to"
    ~ belongs_to :user, optional: true

I think I'm back in business!  
So, I'm back at the original problem: getting nested attributes to persist.  
  * The html that is being produced is correct.  
  * I'm allowing nested attributes at the Project model
  * I think it may be the params.

In rails c, all the association work. I can use the method .build, I can call @project.categories, I can call @category.projects, and this all works perfect.
~ However, I still can't get a @project object to correctly persist with attributes.  
    * Okay, got the collection_check_boxes to persist, after breakfast, I'll work on entering unique category.  

Okay, now add the nested attributes

Got it! So the nest attributes is working. I can choose a category from a list of checkboxes, and I can create a unique category.  

So, what do I want to do next.  
  * I think I'm ready to apply this to the dyi_app

Going to add some styling to the form, with a bootstrap helper gem, and then I will work on link_to categories and projects.  

Bootstrap form_for
  * gem 'bootstrap_form'
  * application.css ~> require rails_bootstrap_forms

Looks good.  

So, as of now, I have a DIY app, that a user can visit, sign up, or login, and create a project.
  * On the index page there is a list of projects and categories. If the user is logged in, they can click to see the details of the project. They also can click on a category, and see a list of projects associated with that category (Going to build that functionality today)
  * I need to double check the nest resources, and make sure that they are correctly applied.
  * I still need to omniauth (Github)
  * And validation warnings.

1. Index page should list all projects and categories. A project with have a link_to so the user can see more details.
2. Also, the index page will have a list of category links. Each link will take the user to a category show page. One the Category show page will be list of projects associated with that category, each project will be a link to the details of that project.
    * So I think I got the main stuff wired up.  I want to style it a bit.

~ I also need to include the users ability to edit their project.
~ I need to make a project template.
~ Also, authentication for login, signup

Okay, right now, I've just cleaned it up a bit, made it as simple as possible. I want to now git the user the a link, or button, to 'create a project'

Side note: refactored the projects#new form with a partial _ form. So partials are not suppose to have any instance variables in them. So I removed all of the form_fields, leaving the |f|, and render 'form', f: f.  This says that I render the partial 'form', and that the variable f is equal to f.  
  * I may want a partial for both the category and the project show page? 
