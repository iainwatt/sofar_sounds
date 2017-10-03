require 'sequel'
# https://github.com/jeremyevans/sequel/blob/master/lib/sequel/model/base.rb

class Song < Sequel::Model
    many_to_one :artist
    one_to_one :video
    many_to_one :city
end

class Artist < Sequel::Model
    one_to_many :song 
end

class Video < Sequel::Model
    one_to_one :song
end

class City < Sequel::Model
    one_to_many :song
end