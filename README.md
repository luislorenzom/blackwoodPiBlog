# BlackwoodPi blog

This project was created for the purpose of learning Ruby on Rails. Futhermore, it is required as a notification way to Blackwood server's users, as well as, a tool to manage the user's quote disk and a few services.

# How to run it
As a rails project first you have to install all the gems
```bash
    bundle install
```
Then you have to migrate the database
```bash
    rails db:migrate
```
Once you have created the database you must to "plant the seeds" :herb::grin:
```bash
    rails db:seed
```
Finally you can run the blog
```bash
    rails server
```

# TODO List

* gemfile.lock security vulnerability
* Stylesheet 
  * Logo
* Profile and user details links to articles
* Generalize feedback panel for the differents forms
* Improve login page
  * "Remember me" checkbox
  * Mail validation? now users should be enabled in the login process
* Add ssl certificate
* Admin page when:
  * Can manage users drive quota
  * Start/Stop required services
  * Show server's info
* Likes articles
  * Show favourites articles into profile
* Statics pages
  * Help
  * How to contribute
  * About me (luislorenzom in the footer)
* File availables page
  * Desing and implement model
  * Controller
  * View
* Add markdown editor to write article's text
* Do the test
* tag cloud format => (tag_name|number_of_articles)
* Show how many likes has each article