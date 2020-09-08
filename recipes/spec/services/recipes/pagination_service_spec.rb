# frozen_string_literal: true

require_relative '../../spec_helper'

describe Recipes::PaginationService do
  before :each do
    ContentfulModel.configure do |config|
      config.access_token = ENV['CONTENTFUL_ACCESS_TOKEN']
      config.space = ENV['CONTENTFUL_SPACE']
    end
  end

  context 'initialization' do
    context 'default params' do
      subject { Recipes::PaginationService.new }

      it 'should respond to default page' do
        expect(subject.send(:page)).to eq(1)
      end

      it 'should respond to default order' do
        expect(subject.send(:order)).to eq('sys.updatedAt')
      end
    end

    context 'custom params' do
      params = { page: 2, order: 'sys.createdAt' }
      subject { Recipes::PaginationService.new(params) }

      it 'should respond to page 2' do
        expect(subject.send(:page)).to eq(2)
      end

      it 'should respond to createdAt order' do
        expect(subject.send(:order)).to eq('sys.createdAt')
      end
    end
  end

  context 'pagination' do
    it 'should return a paginated collection of recipes' do
      vcr('recipes/page_1') do
        result = Recipes::PaginationService.call
        expect(result.success?).to be true
        expect(result.value.class).to eq Contentful::Array
        expect(result.value.size).to eq 4
      end
    end

    it 'should return a empty collection of recipes' do
      vcr('recipes/page_2') do
        result = Recipes::PaginationService.call({ page: 2 })
        expect(result.success?).to be true
        expect(result.value.class).to eq Contentful::Array
        expect(result.value.size).to eq 0
      end
    end
  end
end
