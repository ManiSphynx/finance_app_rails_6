# Finance app 📈
This is a Rails 6 project that demonstrates an example of CRUD for a blog, where you can create, edit, view, and delete articles.

### Requirements 💻
To run this project, you need to have installed:

* Ruby 2.7.x 
* Rails 6.0.2.1
* Bundler 
* Create an account at https://iexcloud.io/ and get your public and secret api key.
* Add the secrets to your environment variables in your rails.credentials.

### Installation ⚙️
1. Clone this repository to your local machine:

```bash 
git clone https://github.com/ManiSphynx/finance_app_rails_6
```

2. Install the dependencies:

```bash 
bundle install
```

3. Create the database:

```bash 
rails db:migrate
```

4. Optionally, you can seed some test data into the database:

```bash 
rails db:seed
```

### Usage 👨‍💻

1. Start the Rails server:

```bash 
rails server
```

2. Open your web browser and visit the address http://localhost:3000.
3. From there you can see the stock price of the most popular companies.

* Optionally run bundle exec rails webpacker:install

### Contributing 🤝

If you want to contribute to this project, please create a pull request with your changes and I'll be happy to review them.

### License 👮‍♂️

This project is available under the MIT License. For more details, please read the LICENSE file.


