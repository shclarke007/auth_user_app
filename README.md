# TASK
Create a ruby based application for a user registration and authentication system. It should be designed as a REST-ful API with JSON only responses, there is no need for views.  
[x] Users need to be able to register with a username, email address and password (there is no need to send a confirmation email).  
[x] Users need to be able to authenticate with their username and password.  
[x] When a user is successfully authenticated, the API needs to respond with a unique user token.  
[x] Groups have a unique name and can have many users and users can belong to many groups.  
[x] Some users have admin privileges and they need to be able to carry out the following actions using a valid user token:  
[x] Create groups.  
[x] Assign users to groups.  

### Ruby version 
3.0.5

### Configuration
```
git clone  
cd auth_user_app  
bundle install  
rails db:create  
rails db:migrate
rails s 
```
### How to run the test suite
```
bundle exec rspec spec/controller/api/v1/groups_controller_spec.rb  
```
## API endpoints
### Sign up a user
http://localhost:3000/users  
```
{
  "username": "tester",
  "email: "example@example.com",
  "password": "password",
  "admin": false
}
```

### Sign in a user
http://localhost:3000/users/sign_in  
```
headers: { Authorization: Bearer token}
```

### Create a group
http://localhost:3000/api/v1/groups    
```
{"group": {
  "users": [user.id, user.id]
}}
```
### Add users to a group
http://localhost:3000/api/v1/groups/{:group_id}/users     
```
{
  "users": [28, 27]
}
```
