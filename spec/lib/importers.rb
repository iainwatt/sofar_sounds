require_relative '../../lib/importers'

RSpec.describe Importers::VideoData, type: :class do
    let(:video_importer) { Class.new }
    # let(:video_importer) { Class.new { extend Importers::VideoData } }

    describe "#import" do
        it "should return false if the input is not a string" do
            result = Importers::VideoData.import({})
            expect(result).to be false 
        end 

        it "should return false if the input is not a valid url" do
            result = Importers::VideoData.import("httd://yolo.com")
            expect(result).to be false 
        end 
    end 

    describe "#get_api_data" do 
        it "should return false if the api call fails" do
            result = Importers::VideoData.get_api_data({})
            expect(result).to be false 
        end         

    end 

end



