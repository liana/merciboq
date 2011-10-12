Feature: Sign up
  In order to get access to protected sections of the site
  As an unregistered user
  I want to sign up

  Background:
    Given no emails have been sent
    And no user exists with an email of "sarahsilverman@test.com"
    And I am not logged in
    And I am on the home page
    And I follow the "Sign up" link
    Then I should see "Merciboq | Sign up" in the title

@wip
    Scenario: Unregistered user signs up with valid email
      And I fill in the following:
        | Email                 | sarah.silverman@test.com     |
      And I press "Sign up"
      Then I should see "You have signed up successfully."
      And I should see a link to "Login"
      And I should see a link to "Sign up"
      And "sarah.silverman@test.com" should have 1 email
      When I open the email
      Then I should see "Confirmation instructions" in the email subject
      And I should see "Sarah Silverman" in the email body
      And I should see "confirm" in the email body
      When I follow "Confirm my account" in the email
      Then I should see "Merciboq | Confirm your account" in the title
      Then I should see "Confirm your account"
      And I should see a link to "Login"
      And the "Name" field should contain "Sarah Silverman"
#      And the "Password" field should contain ********
      And I should see a link to "Sign up"
      And I fill in the following:
        | Password              | password |
        | Password confirmation | password |
      And I press "Accept terms of use and confirm"
      Then I should see "Your account was successfully confirmed."

    @javascript
    Scenario: Unregistered user signs up with invalid email
      And I fill in the following:
        | Email                 | invalidemail    |
      Then I should see "Doesn't look quite right"

