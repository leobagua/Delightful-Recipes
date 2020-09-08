# frozen_string_literal: true

require_relative '../../spec_helper'

describe Recipes::FindService do
  before :each do
    ContentfulModel.configure do |config|
      config.access_token = ENV['CONTENTFUL_ACCESS_TOKEN']
      config.space = ENV['CONTENTFUL_SPACE']
    end
  end

  context 'initialization' do
    subject { Recipes::FindService.new('5jy9hcMeEgQ4maKGqIOYW6') }

    it 'should respond to id' do
      expect(subject.send(:id)).to eq('5jy9hcMeEgQ4maKGqIOYW6')
    end
  end

  context 'find' do
    it 'should return the resource by its id' do
      vcr('recipes/find_5jy9hcMeEgQ4maKGqIOYW6') do
        result = Recipes::FindService.call('5jy9hcMeEgQ4maKGqIOYW6')
        expect(result.success?).to be true
        expect(result.value.id).to eq '5jy9hcMeEgQ4maKGqIOYW6'
      end
    end

    it 'should return an error if the id does not exits' do
      vcr('recipes/find_invalid') do
        result = Recipes::FindService.call('invalid')
        expect(result.success?).to be false
        expect(result.error).to eq 'Recipe not found'
      end
    end
  end
end
