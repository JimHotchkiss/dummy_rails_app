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
