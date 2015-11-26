Feature: Click on a link
	In order to get list of recent read pages

	Scenario: Views recent read pages
		Given I am on localhost
		When I click "Recent Readings"
                Then I should be on recent
