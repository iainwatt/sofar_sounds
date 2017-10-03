
module Importers 
    require 'rest-client'
    class VideoData

        def self.import 
            print "importing data "
            3.times { sleep(0.5); print '.' }
            videos = JSON.parse(RestClient.get("https://s3-eu-west-1.amazonaws.com/sofar-eu-1/video_data.json"))

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