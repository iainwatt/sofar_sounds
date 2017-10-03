require_relative 'models/models'
require 'json'

class SofarApi < Grape::API
    format :json

    helpers do
        # ...
    end

    get '/' do
        JSON.pretty_generate(Application.about)
        # {message: 'Welcome to Sofar Sounds Events Api'}
    end

    get '/videos' do 
        Video.all.map do |v|
            v.to_hash
        end 
    end 

    get '/songs' do 
        Song.all.map do |s|
             s.to_hash
        end 
    end 

    get '/artists' do 
        Artist.all.map do |a|
            a.to_hash
        end 
    end 

    get '/cities' do 
        City.all.map do |c|
            c.to_hash
        end 
    end 


end