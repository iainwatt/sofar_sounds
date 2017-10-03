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
            To run this app just run $ rackup from the base dir
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
        HEREDOC
        slowly do
            about_text
        end 
    end 

    def todo  
        todo_text = <<-HEREDOC
            Complete any routes that need doing
            Sort out any associations that are not fully working 
            Some very basic testing 
            Some font end 
            Add option to pass url to importer
        HEREDOC
        slowly do
            todo_text
        end 
    end 

end

Application = MyApp.new

