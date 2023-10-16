Feature: Get single user POST

Background: 
	Given url 'https://reqres.in'
	And def mainPath = '/api/users/2'
	And def invalidPath = '/api/users/23'
	
Scenario: Verify status code 200
	Given path mainPath
	When method get
	Then status 200
	
Scenario: verify the response similar by expected result
	Given path mainPath
	When method get 
	Then status 200
	And match response == 
	"""
	{
   "data": {
       "id": 2,
       "email": "janet.weaver@reqres.in",
       "first_name": "Janet",
       "last_name": "Weaver",
       "avatar": "https://reqres.in/img/faces/2-image.jpg"
   },
   "support": {
       "url": "https://reqres.in/#support-heading",
       "text": "To keep ReqRes free, contributions towards server costs are appreciated!"
   }
	}
	"""
	
Scenario: Verify the user details like ID or Email
Given path mainPath
When method get
Then status 200
And def data = response.data
And def id = data.id
And def email = data.email
And match id == 2
And match email == 'janet.weaver@reqres.in'

Scenario: Verify the response not found if with invalid path
	Given path invalidPath
	When method get 
	Then status 404
	And match response == 
	"""
	{
	}
	"""
	