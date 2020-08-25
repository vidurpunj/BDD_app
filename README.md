#Unit Tests
- models, views, routes etc
- each individual component is tested one at a time 
- typical result is very good coverage

#Functional Tests
- controllers
- testing multiple components and how they collaborate with each other
- multiple models in process

#Integration Tests
- Integration test is when a business process is followed to completion to meet a bussiness objective
- Typically involves emulating a user, for example logging in and clicking on a purchase button 

Rspec and capybra

- write out the scenario in a test file
 first setp - feature will fail!
 
 - Build the feature one by one till the test poss
 ==> rails g rspec:install
 * generate a binstub for rspec
 bundle binstub rspec-core
 
# Adding Js Frameworks
- yarn add jquery bootstrap popper.js 
- yarn add @fortawesome/fontawesome-free

# Adding Gurad so need not to run test cases manually
  1. gem 'guard', '~> 2.16.2'   ## To automatialy run test cases
  2. gem 'guard-rspec', '~> 4.7.3'
  3. gem 'guard-cucumber', '~> 3.0.0'
  __guard init__  
  
#  listing article
- create two artcile
- list the two artciles
- expect title and body of both test articles

# Devise
- rails g devise:instal
- rails generate devise User
- rails generate devise:views users
- rails generate devise:controllers users <instead of user>

# Show article

