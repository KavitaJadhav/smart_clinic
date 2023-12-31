# Readme

Steps to setup and run application:
1. clone repository - `git@github.com:kavitajadhav/smart_clinic.git`
2. change project directory - `cd cmart_clinic`
3. install libraries - `bundle install`
4. create and setup database - `rails db:create && rails db:migrate`
5. seed sample data - `rails db:seed`
6. run application - `rails server -p 3000`
7. run application console - `rails console`

Commands to run tests:
1. run all tests - `rspec`
2. run single test file (change file_name) - `rspec spec/models/user_spec.rb `
3. run single test in the file- `rspec spec/models/user_spec.rb:15 `


**Note:** Every request needs JWT authentication token. Use curl request shared in API's section to generate authentication token. It is email address based authentication. Sample user data is available in the `seed.rb` file.

# Assumptions
- Application will serve to single clinic at the moment. Assumption is single doctor will be consulting patients. Application will work with having more than one doctors.
- User registration is out of scope for now. Sample user data is added in the application. Use's email will be used for authentication. Managing passwords is out of scope.
- Only authenticated and authorized user will be able to perform any action.
- Every new appointment is considered confirmed unless canceled explicitly.
- Booking slot duration is 15 minutes. Doctor's availability will be displayed as slots of 15 minutes during availability hours.
- Doctors can access schedule and bookings for next 7 days (This is to avoid reading and displaying too much data in api response).
- Updating Doctor's schedule is out of scope.
- Payment will be managed offline.

# Object Modeling
```ruby
class User
  # polymorphic table
  # (:id, :first_name,:last_name,:email)
end

class Doctor < User
end

class Patient < User
end

class WorkingDay
  # (:doctor_id, :date, :to_time, :from_time) 
end

class Appointment
  # (:doctor_id, :patient_id, :date, :to_time, :from_time, :status) 
end
```


# Endpoints For Doctor

#### Get Jwt Token
_Please use JTW token generated by this endpoint to access other endpoints as end user doctor. Set this token value as **Authorization** header in curl request. These curl requests can be imported in postman and access from there._
``Curl --Location --Request Post 'Http://Localhost:3000/Api/V1/Authentication/Login?Email=Priya%40mail.Com'``


#### Get upcoming appointments
``curl --location 'http://localhost:3000/api/v1/doctors/1/appointments' \
--header 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6Imthdml0YSIsImxhc3RfbmFtZSI6ImphZGhhdiIsImVtYWlsIjoia0BqLmNvbSIsInJvbGUiOiJEb2N0b3IiLCJleHAiOjE2OTUyMjg1MjR9.FavwUPpCKJqhyCIKBQ_cIHHy2PgTgc-UtdsWp-D2E1c'``

#### Get doctor's availability
``curl --location 'http://localhost:3000/api/v1/doctors/1/availability' \
--header 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6Imthdml0YSIsImxhc3RfbmFtZSI6ImphZGhhdiIsImVtYWlsIjoia0BqLmNvbSIsInJvbGUiOiJEb2N0b3IiLCJleHAiOjE2OTUyNDEwNjh9.V3s1mRsv4W7WTTqHLqAzzkzcbB9bVTeCZbt71nLbm7k'``


#### Get doctor's work schedule
``curl --location 'http://localhost:3000/api/v1/doctors/1/working_days' \
--header 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6Imthdml0YSIsImxhc3RfbmFtZSI6ImphZGhhdiIsImVtYWlsIjoia0BqLmNvbSIsInJvbGUiOiJEb2N0b3IiLCJleHAiOjE2OTUyMjg1MjR9.FavwUPpCKJqhyCIKBQ_cIHHy2PgTgc-UtdsWp-D2E1c'``

#### Cancel patient's appointment
``curl --location --request PUT 'http://localhost:3000/api/v1/appointments/8/cancel' \
--header 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6Imthdml0YSIsImxhc3RfbmFtZSI6ImphZGhhdiIsImVtYWlsIjoia0BqLmNvbSIsInJvbGUiOiJEb2N0b3IiLCJleHAiOjE2OTUyMjI2NDN9.XTxty4UOyGBQWvOI4A348zh74IamYmJzCgABrPA0A7U'``


# Endpoints For Patient

#### Get Jwt Token
_Please use JTW token generated by this endpoint to access other endpoints as end user patient. Set this token value as **Authorization** header in curl request. These curl requests can be imported in postman and access from there._

``Curl --Location --Request Post 'Http://Localhost:3000/Api/V1/Authentication/Login?Email=Kavita%40mail.Com'``


####  Get list of appointments for patient id
``curl --location 'http://localhost:3000/api/v1/patients/1/appointments' \
--header 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJpZCI6NCwiZmlyc3RfbmFtZSI6Imthdml0YTMiLCJsYXN0X25hbWUiOiJqYWRoYXYiLCJlbWFpbCI6ImszQGouY29tIiwicm9sZSI6IlBhdGllbnQiLCJleHAiOjE2OTUyMzM4ODF9.b3AkLYt2VkjwYt9IFcaVpUjyg0EB9r8V2B7jaWZ0lJM'``


####  Create a new appointment
``curl --location 'http://localhost:3000/api/v1/appointments' \
--header 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJpZCI6NCwiZmlyc3RfbmFtZSI6Imthdml0YTMiLCJsYXN0X25hbWUiOiJqYWRoYXYiLCJlbWFpbCI6ImszQGouY29tIiwicm9sZSI6IlBhdGllbnQiLCJleHAiOjE2OTUyMzM4ODF9.b3AkLYt2VkjwYt9IFcaVpUjyg0EB9r8V2B7jaWZ0lJM' \
--header 'Content-Type: application/json' \
--data '{"appointment":{
"date":"19/09/2023",
"from_time": "19:30",
"to_time": "19:45",
"doctor_id" : 1
}}'``


####  update an appointment
``curl --location --request PUT 'http://localhost:3000/api/v1/appointments/4' \
--header 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJpZCI6NCwiZmlyc3RfbmFtZSI6Imthdml0YTMiLCJsYXN0X25hbWUiOiJqYWRoYXYiLCJlbWFpbCI6ImszQGouY29tIiwicm9sZSI6IlBhdGllbnQiLCJleHAiOjE2OTUyMzM4ODF9.b3AkLYt2VkjwYt9IFcaVpUjyg0EB9r8V2B7jaWZ0lJM' \
--header 'Content-Type: application/json' \
--data '{"appointment":{
"date":"19/09/2023",
"from_time": "18:30",
"to_time": "18:45"
}}'``


####  update an appointment
``curl --location --request PUT 'http://localhost:3000/api/v1/appointments/4/cancel' \
--header 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJpZCI6NCwiZmlyc3RfbmFtZSI6Imthdml0YTMiLCJsYXN0X25hbWUiOiJqYWRoYXYiLCJlbWFpbCI6ImszQGouY29tIiwicm9sZSI6IlBhdGllbnQiLCJleHAiOjE2OTUyMzM4ODF9.b3AkLYt2VkjwYt9IFcaVpUjyg0EB9r8V2B7jaWZ0lJM' \
--data ''``

#### Get doctor's availability
``curl --location 'http://localhost:3000/api/v1/doctors/1/availability' \
--header 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZmlyc3RfbmFtZSI6Imthdml0YSIsImxhc3RfbmFtZSI6ImphZGhhdiIsImVtYWlsIjoia0BqLmNvbSIsInJvbGUiOiJEb2N0b3IiLCJleHAiOjE2OTUyNDEwNjh9.V3s1mRsv4W7WTTqHLqAzzkzcbB9bVTeCZbt71nLbm7k'``
