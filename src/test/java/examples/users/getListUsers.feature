Feature: Get List Users

Background: 
	Given url "https://reqres.in"
	And print 'url is correct'
	
Scenario: Verify status code 200
	Given path '/api/users'
	And param page = 2
	When method get
	Then status 200
	
Scenario: Verify all field exist
	Given path '/api/users'
	And param page = 2
	When method get
	Then status 200
	And match response == 
	"""
	
	{
		 "page": '#notnull',
	   "per_page": '#notnull',
	   "total": '#present',
	   "total_pages": "#ignore",
	   "data" : "#array", 
	   "support" : "##object"
	}
	""" 
	
	And match response.data[*] contains 
	"""
	{
		id:'#number? _ > 0', 
		email:'#regex .+@reqres.in', 
		first_name:'#string', 
		last_name:'#string', 
		avatar: '#string'
	}
	"""
	
	
Scenario: Verify the response match with expected result
	Given path '/api/users'
	And param page = 2
	When method get
	Then status 200
	And print response
	And match response == 
	"""
		{
	    "page": 2,
	    "per_page": 6,
	    "total": 12,
	    "total_pages": 2,
	    "data": [
	        {
	            "id": 7,
	            "email": "michael.lawson@reqres.in",
	            "first_name": "Michael",
	            "last_name": "Lawson",
	            "avatar": "https://reqres.in/img/faces/7-image.jpg"
	        },
	        {
	            "id": 8,
	            "email": "lindsay.ferguson@reqres.in",
	            "first_name": "Lindsay",
	            "last_name": "Ferguson",
	            "avatar": "https://reqres.in/img/faces/8-image.jpg"
	        },
	        {
	            "id": 9,
	            "email": "tobias.funke@reqres.in",
	            "first_name": "Tobias",
	            "last_name": "Funke",
	            "avatar": "https://reqres.in/img/faces/9-image.jpg"
	        },
	        {
	            "id": 10,
	            "email": "byron.fields@reqres.in",
	            "first_name": "Byron",
	            "last_name": "Fields",
	            "avatar": "https://reqres.in/img/faces/10-image.jpg"
	        },
	        {
	            "id": 11,
	            "email": "george.edwards@reqres.in",
	            "first_name": "George",
	            "last_name": "Edwards",
	            "avatar": "https://reqres.in/img/faces/11-image.jpg"
	        },
	        {
	            "id": 12,
	            "email": "rachel.howell@reqres.in",
	            "first_name": "Rachel",
	            "last_name": "Howell",
	            "avatar": "https://reqres.in/img/faces/12-image.jpg"
	        }
	    ],
	    "support": {
	        "url": "https://reqres.in/#support-heading",
	        "text": "To keep ReqRes free, contributions towards server costs are appreciated!"
	    }
	}

	"""
	
	Scenario: Verify the specific response correct
		Given path '/api/users'
		And param page = 2
		When method get
		Then status 200
		And def responseData = response.data
		And print responseData
		And def id = responseData[0].id
		And print id 
		And match id == 7
		And def responseDataFirstName = response.data.first_name
		And def firstName = responseData[0].first_name
		And print firstName
		Then match firstName == "Michael"
	
