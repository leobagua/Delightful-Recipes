require_relative '../spec_helper'

describe 'Routes' do
  context '200' do
    before :each do
      ContentfulModel.configure do |config|
        config.access_token = ENV['CONTENTFUL_ACCESS_TOKEN']
        config.space = ENV['CONTENTFUL_SPACE']
      end
    end

    it 'should respond with 200 at /' do
      vcr('recipes/page_1') do
        get '/'

        expect(last_response).to be_ok
      end
    end

    it 'should respond with 200 at /:id' do
      vcr('recipes/find_5jy9hcMeEgQ4maKGqIOYW6') do
        get '/5jy9hcMeEgQ4maKGqIOYW6'

        expect(last_response).to be_ok
      end
    end
  end

  context '404' do
    it 'should respond with 404 at /:id' do
      get '/invalid'

      expect(last_response).to be_not_found
    end
  end

  context '500' do
    it 'should respond with 500 at /' do
      get '/'

      expect(last_response).to be_server_error
    end
  end
end