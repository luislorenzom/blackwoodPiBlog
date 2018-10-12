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

* gemfile.lock security vulvenaryvilty
* Model's policies
  * at controllers
  * at views
* Stylesheet 
  * Logo
  * Article details
* Profile and user details links to articles
* Generalize feedback panel for the differents forms
* Improve login page
  * Add feedback panel
  * "Remember me" checkbox
  * Mail validation? now users should be enabled in the login process
* Add ssl certificate
* Admin page when:
  * Can manage users drive quota
  * Start/Stop required services
  * Show server's info
* Likes articles
  * Create model's relation
  * Add link button
  * show favourites articles people's profile
* Add code to manage special article within welcome page
  * fixed articles
  * top articles
* Statics pages
  * Help
  * How to contribute
  * About me (luislorenzom in the footer)
* File availables page
  * Desing and implement model
  * Controller
  * View
* Recommend other article in articles details page