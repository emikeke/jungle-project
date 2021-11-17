require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'User can be created with first name, last name, email, password, and password confirmation' do
      @user = User.new(first_name: 'Chai', last_name: 'Mysore', email: 'chai@gmail.com', password: 'jungle', password_confirmation: 'jungle')
      expect(@user).to be_valid
    end

    it 'should pass when first name, last name and email are not provided' do
      @user = User.new(password: 'jungle', password_confirmation: 'jungle')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "First name can't be blank"
      expect(@user.errors.full_messages.second).to eq "Last name can't be blank"
      expect(@user.errors.full_messages.third).to eq "Email can't be blank"
    end

    it 'should pass when email is not unique' do
      @user1 = User.create(first_name: 'Chai', last_name: 'Mysore', password: 'jungle', password_confirmation: 'jungle', email: 'chai@gmail.com')
      @user2 = User.new(first_name: 'Chaitra', last_name: 'Urs', password: 'junglebook', password_confirmation: 'junglebook', email: 'CHAI@GMAIL.COM')
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages.first).to eq "Email has already been taken"
    end

    it 'should pass when password entered is not within the range of 6 to 20 characters' do
      @user = User.new(first_name: 'Chai', last_name: 'Mysore', password: 'abc', password_confirmation: 'abc', email: 'CHAI@GMAIL.com')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Password is too short (minimum is 6 characters)"
    end

    it 'should pass when password and password confirmation does not match' do
      @user = User.new(first_name: 'Chai', last_name: 'Mysore', password: 'jungle', password_confirmation: 'junglebook', email: 'chai@gmail.com')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Password confirmation doesn't match Password"
    end

  end


  describe '.authenticate_with_credentials' do

    before do
      @user = User.create(first_name: 'Chai', last_name: 'Mysore', password: 'jungle', password_confirmation: 'jungle', email: 'chai@gmail.com')
      expect(@user).to be_valid
    end

    it 'should log in with correct email and password' do
      @login_attempt = User.authenticate_with_credentials('chai@gmail.com', 'jungle')
      expect(@login_attempt.first_name).to eq 'Chai'
      expect(@login_attempt.last_name).to eq 'Mysore'
    end

    it 'should log in with correct email and password, including spaces in email' do
      @login_attempt = User.authenticate_with_credentials('  chai@gmail.com  ', 'jungle')
      expect(@login_attempt.first_name).to eq 'Chai'
      expect(@login_attempt.last_name).to eq 'Mysore'
    end

    it 'should log in with correct email and password, including wrong letter case in email' do
      @login_attempt = User.authenticate_with_credentials('CHAi@GmAiL.CoM', 'jungle')
      expect(@login_attempt.first_name).to eq 'Chai'
      expect(@login_attempt.last_name).to eq 'Mysore'
    end

    it 'should fail to login when email address is nil' do
      @login_attempt = User.authenticate_with_credentials(nil, 'jungle')
      expect(@login_attempt).to be_nil
    end

    it 'should fail to login with incorrect email address' do
      @login_attempt = User.authenticate_with_credentials('chai@ymail.com', 'jungle')
      expect(@login_attempt).to be_nil
    end

    it 'should fail to login when password is nil' do
      @login_attempt = User.authenticate_with_credentials('chai@gmail.com', nil)
      expect(@login_attempt).to be_nil
    end

    it 'should fail to login with incorrect password' do
      @login_attempt = User.authenticate_with_credentials('chai@gmail.com', 'junglebook')
      expect(@login_attempt).to be_nil
    end

  end

end
