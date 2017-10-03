require 'sequel'
# https://github.com/jeremyevans/sequel/blob/master/lib/sequel/model/base.rb

class Song < Sequel::Model
    one_to_many :artist
    one_to_many :video
    one_to_many :city
end

class Artist < Sequel::Model
    many_to_one :song 
end

class Video < Sequel::Model
    many_to_one :song
end

class City < Sequel::Model
    many_to_one :song
end