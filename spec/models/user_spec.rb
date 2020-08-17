require 'rails_helper'

RSpec.describe User do
  context 'when saving' do
    it 'transform email to lower case' do
      toni = create(:user, email: 'TESTING@TEST.COM')

      expect(toni.email).to eq 'testing@test.com'
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:recipes) }

    describe 'dependency' do
      let(:recipes_count) { 1 }
      let(:user) { create(:user) }

      it 'destroys recipes' do
        create_list(:recipe, recipes_count, user: user)

        expect { user.destroy }.to change { Recipe.count }.by(-recipes_count)
      end
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:password) }

    it { is_expected.to have_secure_password }

    context 'when matching uniqueness of name' do
      subject { create(:user) }
      it { is_expected.to validate_uniqueness_of(:name) }
    end

    context 'when matching uniqueness of email' do
      subject { create(:user) }
      it { is_expected.to validate_uniqueness_of(:email) }
    end

    it { is_expected.to validate_length_of(:name).is_at_least(User::MINIMUM_NAME_LENGTH) }
    it { is_expected.to validate_length_of(:name).is_at_most(User::MAXIMUM_NAME_LENGTH) }
    it { is_expected.to validate_length_of(:email).is_at_most(User::MAXIMUM_EMAIL_LENGTH) }
    it { is_expected.to validate_length_of(:first_name).is_at_most(User::MAXIMUM_NAME_LENGTH) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(User::MAXIMUM_NAME_LENGTH) }
    it { is_expected.to validate_length_of(:password).is_at_least(User::MINIMUM_PASSWORD_LENGTH) }

    context 'when using invalid email format' do
      it 'is invalid' do
        toni = build(:user, email: 'test@invalid')

        expect(toni.valid?).to be false
      end
    end
  end
end
