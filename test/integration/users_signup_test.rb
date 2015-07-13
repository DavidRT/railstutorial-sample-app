require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
	test "invalid signup information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { name: "",
									 email: "user@email",
									 password: 	"foo",
									 password_confirmation: "bar"}

		end
		assert_template 'users/new'
		
		assert_select 'div#error_explanation' do |elements|
			elements.each do |element|
				assert_select element,"div.alert"
				assert_select element,"ul"
			end
		end
    	
	end

	test "valid signup information" do
		get signup_path
		assert_difference 'User.count', 1 do
			post_via_redirect users_path, user:{
										name: "Example12345",
										email: "example12354@example.com",
										password: "foobar",
										password_confirmation: "foobar"}
		end
		assert_template 'users/show'
		assert_not flash.empty?
	end

end
