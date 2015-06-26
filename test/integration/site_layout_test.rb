require 'test_helper'

# rails generate integration_test site_layout
# run: bundle exec rake test:integration
class SiteLayoutTest < ActionDispatch::IntegrationTest
 	
 	test "layout_links" do
 		get root_path
 		assert_template 'static_pages/home'

 		# parameter count verifies that there are two hrf with root_path
 		assert_select "a[href=?]", root_path, count: 2
 		assert_select "a[href=?]", help_path
 		assert_select "a[href=?]", about_path
 		assert_select "a[href=?]", contact_path
 		assert_select "a[href=?]", signup_path

 		# for testing that title in each page is correct
 		get signup_path 
 			assert_select "title", full_title("Sign up")
 		get contact_path
 			assert_select "title", full_title("Contact")
 		get about_path
 			assert_select "title", full_title("About")
 		get help_path
 			assert_select "title", full_title("Help")
 		get root_path
 			assert_select "title", full_title("")
 	end

end
