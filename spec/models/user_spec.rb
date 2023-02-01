require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'the user has name with nil' do
      @user = User.create(name: nil, email: 'user1@email.com', password: '123456', password_confirmation: '123456')
      expect(@user).not_to be_valid
    end

    it 'the user has password with nil' do
      @user = User.create(name: 'user2', email: 'user2@email.com', password: nil)
      expect(@user).not_to be_valid
    end

    it 'the user has password_confirmation with nil' do
      @user = User.create(name: 'user3', email: 'user3@email.com', password_confirmation: nil)
      expect(@user).not_to be_valid
    end

    it 'the user has not matched password and password_confirmation' do
      @user = User.create(name: 'user4', email: 'user4@email.com', password: '123456', password_confirmation: '1234567')
      expect(@user).not_to be_valid
    end

    it 'is invalid if the same email has been used' do
      @user1 = User.create(name: 'user5', email: 'user5@email.com', password: '123456')
      @user2 = User.create(name: 'user5', email: 'user5@email.com', password: '123456')
      expect(@user1).to be_valid
      expect(@user2).not_to be_valid
    end

    it 'is valid if the different email' do
      @user1 = User.create(name: 'user5', email: 'user5@email.com', password: '123456')
      @user2 = User.create(name: 'user5', email: 'user6@email.com', password: '123456')
      expect(@user1).to be_valid
      expect(@user2).to be_valid
    end

    # Email and name should also be required
    it 'is invalid if no name' do
      @user = User.create(email: 'user7@email.com', password: '123456', password_confirmation: '123456')
      expect(@user).not_to be_valid
    end

    it 'is invalid if no email' do
      @user = User.create(name: 'user7', password: '123456', password_confirmation: '123456')
      expect(@user).not_to be_valid
    end

    # Password minimum length
    it 'is invalid if password length is too short' do
      @user = User.create(name: 'user7', email: 'user7@email.com', password: '12', password_confirmation: '12')
      expect(@user).not_to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'return nil if password is wrong' do
      @user = User.create(name: 'user', email: 'user@email.com', password: '123456', password_confirmation: '123456')

      auth_user = User.authenticate_with_credentials("user@email.com", "222333")
      expect(auth_user).to be_nil
    end

    it 'return user if email and password are correct' do
      @user = User.create(name: "user", email: "user@email.com", password: "123456", password_confirmation:"123456")
  
      auth_user = User.authenticate_with_credentials("user@email.com","123456")
      expect(auth_user.email).to eq(@user.email)
    end

    it 'return user if email and password are correct (uppercase and dowcase)' do
      @user = User.create(name: "user", email: "user@email.com", password: "123456", password_confirmation:"123456")
  
      auth_user = User.authenticate_with_credentials("USER@email.com","123456")
      expect(auth_user.email).to eq(@user.email)
    end

  end
end
