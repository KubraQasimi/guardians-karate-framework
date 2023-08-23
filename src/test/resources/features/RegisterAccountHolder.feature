#this feature is to test register account holder
#reguire and existing account
#require random username
@regression
Feature: Register new user and new account
Background: Setup tests and create new account
Given url "https://tek-insurance-api.azurewebsites.net"
* def createAccountresult = callonce read('CreateAccount.feature')
* def accountId = createAccountresult.response.id
* def fullName = createAccountresult.response.firstname + " " + createAccountresult.response.lastname

Scenario: Sign up and register new user
Given path "/api/sign-up/register"
* def dataGenerator = Java.type('api.utility.data.generateData')
* def auto_username = dataGenerator.getUserName()
And request 
"""
{
  "primaryPersonId": "#(accountId)",
  "fullname": "#(fullName)",
  "username": "#(auto_username)",
  "password": "Password@123",
  "authority": "CUSTOMER",
  "accountType": "CUSTOMER"
}
"""
When method post
Then print response
Then status 201
And assert response.username == auto_username