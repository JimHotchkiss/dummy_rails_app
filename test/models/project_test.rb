require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test "should not save project without title" do
    project = Project.new
    assert_not project.save, 'Saves project without title'
  end
end
