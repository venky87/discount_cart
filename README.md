# README

* Project follow DDD (Domain Driven Desing).
* Have created service object to fetch discounts based on multiples or basket price 
* Rspec for discount calculation is added
* Run the app by running
### Installation
- Clone the repository
- Do bundle install
  ## DB migration
   ```sh
   $ bundle exec rake db:create
   $ bundle exec rake db:migrate
   ```
- Once the DB migrations are run, run the following command to run the server
```sh 
$ rails s
```
* Go to http://localhost:3000/swagger to find API documentation

### Running RSpec
```sh
$ rspec spec/domains/discounts/services/
```
- Test cases are implemented for discount calulations
