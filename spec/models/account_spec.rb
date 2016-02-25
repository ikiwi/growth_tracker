require 'rails_helper'

RSpec.describe Account, :type => :model do
    
  describe 'new' do
    it 'creates new account' do
      account = Account.new(:name => "me")
      expect(account.name).to eq "me"
    end
  end
  
end