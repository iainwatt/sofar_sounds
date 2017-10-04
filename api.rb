require_relative 'models/models'
require 'json'

class SofarApi < Grape::API
    format :json


    get '/' do
        {message: 'Welcome to Sofar Sounds Events Api'}
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

    get '/import' do 
        response = false
        if params.key?("url")
            response = Application.perform_import(params["url"]) 
        else
            response = Application.perform_import 
        end
        response = "no import performed" if !response
        {message: response} 
    end 


end