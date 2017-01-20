# FetchIt

[FetchIt](https://dom-mckellar-fetchit.herokuapp.com/) is a Task Running (aka Delivery) service application based on a fictitious company located in San Francisco, CA.

It was designed with both the customer and business in mind. Where customers have the ability to create an account, place orders, and access their order history. While from the business side, a manager(s) have the capacity to create and customize various services to meet their needs. In addition, business managers' have built in administrative privileges to both keep track of orders and manage user accounts.

This project was built in Rails 5, styled by Twitter Boostrap, and includes additional gems such as Devise (authentication), OmniAuth (optional Facebook sign up), Pundit (authorization), and more.


## Installation
#### (Step 1) Clone a local copy of the `fetch_it` repo.
`$ git clone https://github.com/YOUR-USERNAME/fetch_it.git`

#### (Step 2) Run Bundler to install gem dependencies:
```
$ cd fetch_it/
$ bundle install
```
#### (Step 3) Migrate the database:
`$ bin/rails db:migrate`

#### (Step 3) Populate the database with seed data:
`$ bin/rails db:seed`

#### (Step 4) Administrative Privileges:
* By default a user is automatically assigned the role of "customer" upon creation. In order to give a user administrative privileges, you must do so via the *rails console*.
`$ bin/rails console`

* You can either create an account through the application and update the user's role to "manager" afterwards (in the console):

```
$ user = User.last
$ user.role = "manager"
$ user.save
```
* Note: you could optionally run the following command which will assign the role and save it in the same step:

```
$ user = User.last
$ user.manager!
```

* Another option is to simply create a user directly in the console:

```
$ User.create(email: "your_email@example.com", password: "your_password", password_confirmation: "your_password", role: "manager")
```
* Note: Passwords by default are 6 characters in length, however this can be changed in the `config/initializer/devise.rb` file.

## Future Todo Items
- Add page titles.
- Add employee capabilities.
- Allow managers to edit and delete orders.
- Allow customers to delete their account (while preserving orders/records).
- Add additional placeholders to forms (specifically date and time fields).


## Creator
###### [Dominic McKellar](https://twitter.com/_dom_mc)
* [Website | domckellar.com](http://domckellar.com/)
* [Blog | newme.io](http://newme.io/)
* [Github | Dom-Mc](https://github.com/Dom-Mc)

## License

FetchIt is an open-sourced software licensed under the MIT license.

## Contributing
Fork it
Create your feature branch: `git checkout -b my-new-feature`
Commit your changes: `git commit -am 'Add some feature'`
Push to the branch: `git push origin my-new-feature`
Create new Pull Request
