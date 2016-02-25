require 'rails_helper'

RSpec.describe Story, :type => :model do
    
  describe 'new' do
    it 'creates a new story' do
      story = Story.new(:title => "test", :text => "testtest")
      expect(story.title).to eq "test"
    end
  end
  
end
