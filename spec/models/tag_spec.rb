require 'rails_helper'

RSpec.describe Tag, :type => :model do
    
  describe 'new' do
    it 'creates a new tag' do
      tag = Tag.new(:story_id => 0)
      expect(tag.story_id).to eq 0
    end
  end
  
end
