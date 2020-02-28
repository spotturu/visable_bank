## Visable Bank Application

* Visable Bank System Application
* Rails 6
* Ruby 2.5.7 

* Automatically pushes it to dockerhub if tests pass

## Installation
```bash
git clone https://github.com/spotturu/visable_bank.git
cd visable_bank
bundle install
rake db:setup
rails s
```
Note: SMS Integration service added with limited sms on registered mobile. Users added in seeds.rb

## API

### generate token
```bash
curl -H 'Content-Type: application/json' -d '{"email": "test1@vb.com", "password": "123123123"}' -X POST 'http://localhost:3000/token'
```

### open a new account
```bash
curl -H 'Content-Type: application/json' -d '{"name": "Commerze Bank", "user_id": 1}' -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST 'http://localhost:3000/accounts'
```

### deposit into account
```bash
curl -H 'Content-Type: application/json' -d '{"amount": 50.00}' -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST 'http://localhost:3000/accounts/<account_id>/deposit'
```

### withdraw from account
```bash
curl -H 'Content-Type: application/json' -d '{"amount": 19.99}' -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST 'http://localhost:3000/accounts/<account_id>/withdraw'
```

### balance from account
```bash
curl -H 'Content-Type: application/json' -H "Authorization: Bearer <ACCESS_TOKEN>" -X GET 'http://localhost:3000/accounts/<account_id>/balance'
```

### transfer from one account to another account
```bash
curl -H 'Content-Type: application/json' -d '{"recipient_id": <reciever_account_id>, "amount": 19.99}' -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST 'http://localhost:3000/accounts/<account_id>/transfer'
```

### account mini statement with recent 10 transactions
```bash
curl -H 'Content-Type: application/json'  -d '{"no_of_days": 2}' -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST 'http://localhost:3000/accounts/<account_id>/mini_statement'
```