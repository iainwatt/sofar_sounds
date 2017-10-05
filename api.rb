require_relative 'models/models'
require 'json'

class SofarApi < Grape::API
    format :json

    get '/' do
        {message: 'Welcome to Sofar Sounds Events Api'}
    end

    get '/videos' do
        Video.all.map(&:to_hash)
    end

    get '/songs' do
        Song.all.map(&:to_hash)
    end

    get '/artists' do
        Artist.all.map(&:to_hash)
    end

    get '/cities' do
        City.all.map(&:to_hash)
    end

    get '/import' do
        response = false
        if params.key?('url')
            response = Application.perform_import(params['url'])
        else
            response = Application.perform_import
        end
        response ||= 'no import performed'
        {message: response}
    end

end
