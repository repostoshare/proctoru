# Assessment API 3000

Welcome to Assessment API 3000! Where we make all your assessment api
dreams come true. 

In order to provide the best service possible, please 
take the following steps as setup may have changed.

## Setup
1. Setup the programming language known as "Ruby"
2. Setup the web development framework "Ruby on Rails"
3. Pull down this codebase to your local machine.

Then run the following commands on your terminal:
1. cp config/database.yml.example config/database.yml
1. bundle exec rails db:create
2. bundle exec rails db:migrate
3. bundle exec rails db:seed (Take note of the output)
4. bundle exec rails server

You will now be able to post data to the api and setup an assessment.
Use either your terminal to run the requests or a GUI API client
like Insomnia or Postman.

## Example Requests(use the latest data shown after running db:seed)

### An assessment should not be created and the request will return a 400

#### Time available to take exam has passed
curl -H "Content-Type: application/json" -X POST -d '{"college_id":"1",
                                                      "exam_id":"2",
                                                      "start_time": "2021-05-03 21:31:13",
                                                      "first_name": "Scott",
                                                      "last_name": "McFarland",
                                                      "phone_number": "1234567890"
                                                     }' http://localhost:3000/api/v1/assessments

#### The user is not eligible for a level 2 exam
curl -H "Content-Type: application/json" -X POST -d '{"college_id":"2",
                                                      "exam_id":"3",
                                                      "start_time": "2021-05-03 21:31:13",
                                                      "first_name": "Michael",
                                                      "last_name": "Scott",
                                                      "phone_number": "0987654321"
                                                     }' http://localhost:3000/api/v1/assessments



### An assessment should be created and the request will return a 200

#### With an existing user:
curl -H "Content-Type: application/json" -X POST -d '{"college_id":"1",
                                                      "exam_id":"1",
                                                      "start_time": "2021-05-03 21:31:13",
                                                      "first_name": "Scott",
                                                      "last_name": "McFarland",
                                                      "phone_number": "1234567890"
                                                     }' http://localhost:3000/api/v1/assessments

#### With a new user:
curl -H "Content-Type: application/json" -X POST -d '{"college_id":"1",
                                                      "exam_id":"1",
                                                      "start_time": "2021-05-03 21:31:13",
                                                      "first_name": "Asad",
                                                      "last_name": "Akbar",
                                                      "phone_number": "5105125470"
                                                     }' http://localhost:3000/api/v1/assessments

Created By:  
Asad Akbar | asadakbar@hey.com | 510-512-5470