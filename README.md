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
rails s
```

## API
### create user
```bash
curl -H 'Content-Type: application/json' -d '{"email": "visable@mail.com", "password": "123123123"}' -X POST 'http://localhost:3000/users'
```

### generate token
```bash
curl -H 'Content-Type: application/json' -d '{"email": "visable@mail.com", "password": "123123123"}' -X POST 'http://localhost:3000/token'
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

### transfer from one account to another account
```bash
curl -H 'Content-Type: application/json' -d '{"recipient_id": <reciever_account_id>, "amount": 19.99}' -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST 'http://localhost:3000/accounts/<account_id>/transfer'
```

### account mini statement with recent 10 transactions
```bash
curl -H 'Content-Type: application/json' -H "Authorization: Bearer <ACCESS_TOKEN>" -X POST 'http://localhost:3000/accounts/<account_id>/mini_statement'
```