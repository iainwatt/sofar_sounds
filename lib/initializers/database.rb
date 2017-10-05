# DB = Sequel.sqlite
DB = Sequel.connect("postgres://#{ENV['PGHOST']}/#{ENV['PGDATABASE']}?user=#{ENV['PGUSER']}&password=#{ENV['PGPASS']}")


DB.create_table?(:artists) do
    Integer :artist_id, unique: true, primary_key: true
    String :title
    String :cached_slug
    Integer :song_id
end

DB.create_table?(:videos) do
    String :video_uid, unique: true, primary_key: true
    Integer :song_id
end

DB.create_table?(:cities) do
    Integer :city_id, unique: true, primary_key: true
    String :title
    String :cached_slug
    Integer :song_id
end


DB.create_table?(:songs) do
    Integer :song_id, unique: true, primary_key: true
    String :title
    String :cached_slug
    foreign_key :artist_id, :artists
    foreign_key :city_id, :cities
    foreign_key :video_uid, :videos, type: 'varchar(255)'
end

