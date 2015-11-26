Feature: Sign Up
	In order to sign up to JustReadIt!
     	A visitor
	Should enter his credentials

	Scenario: Signing Up to website
		Given I am on signup
		And I fill in "user_username" with "Cucumber User"
                And I fill in "user_email" with "Cucumber@User.co"
                And I fill in "user_password" with "Cucumber0s123"
                And I fill in "user_password_confirmation" with "Cucumber0s123"
		When I press "Sign up"
		Then I should be on the home page
		

