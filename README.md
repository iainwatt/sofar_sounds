# Requirements 
This app requires Postgresql to run, if you don't already have it then ...
```sh
brew install postgresq
```
A JSON viewer browser plugin makes things more readable.
# Setup
Start a local db server
```sh
$ postgres -D /usr/local/var/postgres
```
Install gem dependencies 
```sh
$ bundle install
```
Create the database 
```sh
$ rake db:create 
```
Start the server 
```sh
$ rackup
```
You can now navigate to http://localhost:9292/import to import the data.
View imported data at http://localhost:9292/songs  (or /videos, /artists, /cities)

# About  
The idea was to fufill the test requirement in the most simple way possible and also try some things I have not used before like:
- Using the ruby-grape gem
- Creating my own rails free projet 
- Trying a new ruby ORM / db 
- Exploring rack 
- Using the tap method
- Exploring core Ruby classes and methods
- Other useful command are: irb -r ./some_file.rb (to get into the ruby interpreter)
 # Negatives
- Using a new ORM and unfamiliar DB with lack of GUI and familiar rails methods has been time consuming particularly error messages (from postgress), associations and foreign keys
- I miss auto-reload
- Its not easy or obvious how to impliment a useful inheritance structure 
# Positives 
- ruby-grape is easy to use
- created rails-esque file structure is satisfying and very pleasing to know all of the application
- A framework-less ruby app is still 1000 times nicer than a php app.
