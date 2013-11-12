module ValidUserRequestHelper
	include Warden::Test::Helpers
	Warden.test_mode!

  # for use in request specs
  def sign_in_as_a_valid_user
    user ||= FactoryGirl.create :user
    login_as(user, :scope => :user, :run_callbacks => false)
  end
end
