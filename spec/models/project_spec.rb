require 'rails_helper'

describe Project do
  it 'can be created' do
    #project = Project.create!(title: "My title", description: "The post description")
    project = Project.create!(title: "My title")
    expect(project).to be_valid
  end
end
