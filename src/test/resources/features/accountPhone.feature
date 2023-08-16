@regression
Feature: create account and add phone number

Background: setup test and create account
* def createAccountRes = callonce read('CreateAccount.feature')
And print createAccountRes
* def validToken = createAccountRes.validToken
* def createdAccountId  = createAccountRes.response.id
Given url "https://tek-insurance-api.azurewebsites.net"

Scenario: adding phone number to an account
 Given path "/api/accounts/add-account-phone"
 And param primaryPersonId = createdAccountId
 And header Authorization = "Bearer " + validToken
 * def dataGenerator = Java.type('api.utility.data.generateData')
 * def phoneNumber = dataGenerator.getPhoneNumber()
 And request
 """
 {
  "phoneNumber": "#(phoneNumber)",
  "phoneExtension": "",
  "phoneTime": "evening",
  "phoneType": "mobile"
}
 
 """
 When method post
 Then status 201
 And  assert response.phoneNumber == phoneNumber
