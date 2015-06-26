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
 	end

end
