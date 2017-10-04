
module Importers 
    require 'rest-client'
    require 'uri'
    class VideoData

        def self.get_api_data(url)
            videos = false 
            begin 
               videos = JSON.parse(RestClient.get(url))
            rescue Exception => e
                puts "something went wrong getting videos"
            end 
            videos
        end 

        def self.import(url=nil)
            get_videos_url = "https://s3-eu-west-1.amazonaws.com/sofar-eu-1/video_data.json"
            get_videos_url = url if !url.nil?

            return false if !url.is_a?(String) || !(url =~ URI::regexp(%w(http https)))

            print "importing data "
            3.times { sleep(0.5); print '.' }

            videos = [self.get_api_data(url)]
            return false if !videos || !videos.is_a?(Array)

            # ---------------------------- #
            # we do this as setting primary key is restricted by default 
            Video.unrestrict_primary_key
            Artist.unrestrict_primary_key
            Song.unrestrict_primary_key
            City.unrestrict_primary_key
            # ---------------------------- #
            
            videos.each do |v|
                begin 
                    song_id = (v.key?("song") && v["song"]["id"]) ? v["song"]["id"] : nil
                    Video.create(video_uid: v["video_uid"], song_id: song_id) if Video.find(video_uid: v["video_uid"]).nil?
                    if song_id
                        City.create(v["song"]["city"].tap { |c| c["song_id"] = song_id; c["city_id"] = c["id"]; c.delete "id"}) if v["song"]["city_id"] && v["song"]["city"] && City.find(city_id: v["song"]["city_id"]).nil?
                        artist = v["song"]["artist"].tap { |c| c["song_id"] = song_id; c["artist_id"] = c["id"]; c.delete "id"} if v["song"]["artist_id"]
                        Artist.create(artist) if v["song"]["artist"] && Artist.find(artist_id: artist["artist_id"]).nil?
                        song = v["song"].tap { |s| s["song_id"] = s["id"]; s["video_uid"] = v["video_uid"]; s.delete "id"; s.delete("artist") if s.key?("artist"); s.delete("city") if s.key?("city") } if v["song"]["id"]
                        Song.create(song) if Song.find(song_id: song["song_id"]).nil?
                    end 
                rescue Exception => e 
                    puts "EXCEPTION!:  #{e}"
                end
            end # video loop end
            return "#{videos.count} videos returned from api. Created: {videos: #{Video.all.count}, songs: #{Song.all.count}, cities: #{City.all.count}}"
        end 
    end
end # class end