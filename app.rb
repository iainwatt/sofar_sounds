require 'sequel'
require 'rest-client'

require_relative 'lib/initializers/database'
require_relative 'models/models'
require_relative 'lib/importers'


class MyApp

    def perform_import 
        Importers::VideoData.import
    end

    def slowly
        yield.each_char { |c| putc c; $stdout.flush; sleep 0.05 };0
    end

    def about
        about_text =  <<-HEREDOC
            REQUIREMENTS / SETUP 
            - Postgresql (brew install postgresql on mac) sorry !
            - You may need to start a local postgres server (postgres -D /usr/local/var/postgres)
            - Install a JSON viewer to your browser to make it look pretty 
            - run bundle install 
            - $ rackup (from base dir to start a server)
            - navigate to http://localhost:9292/import to import the data 
            - View imported data at http://localhost:9292/songs  or /videos or /artists 
            ABOUT 
            The idea was to fufill the test requirement in the most simple way possible and 
            also try some things I have not used before like;
            - Using the ruby-grape gem
            - Creating my own rails free projet 
            - Trying a new ruby ORM / db 
            - Exploring rack 
            - Using the tap method
            - Exploring core Ruby classes and methods
            - Other useful command are: irb -r ./some_file.rb (to get into the ruby interpreter)
            NEGATIVES
            - Using a new ORM and unfamiliar DB with lack of GUI and familiar rails methods has been time consuming
            particularly error messages (from postgress), associations and foreign keys
            - I miss auto-reload
            - Its not easy or obvious how to impliment a useful inheritance structure 
            POSITIVES
            - ruby-grape is easy to use
            - created rails-esque file structure is satisfying and very pleasing to know all of the application
            - A framework-less ruby app is still 1000 times nicer than a php app.
        HEREDOC
        slowly do
            about_text
        end 
    end 

end

Application = MyApp.new

