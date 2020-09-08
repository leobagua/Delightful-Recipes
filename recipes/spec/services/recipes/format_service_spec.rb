# frozen_string_literal: true

require_relative '../../spec_helper'

describe Recipes::FormatService do
  context 'record' do
    context 'with all params' do
      subject do
        OpenStruct.new(
          id: '5jy9hcMeEgQ4maKGqIOYW6',
          title: 'My Title',
          calories: 450,
          photo: OpenStruct.new(url: 'https://somephoto.to.recipe.com/image.jpg'),
          chef: OpenStruct.new(name: 'Recipe Chef'),
          tags: [OpenStruct.new(name: 'Tag 1'), OpenStruct.new(name: 'Tag 2')],
          description: <<~DESCRIPTION
            *Recipe 101*: This is my __recipe__.
            Check the instructions [video](https://somelink.to.video.com)
        DESCRIPTION
        )
      end

      it 'should be an instance of OpenStruct' do
        result = Recipes::FormatService.call(subject)

        expect(result.value.class).to eq OpenStruct
      end

      it 'should parse standard attributes' do
        result = Recipes::FormatService.call(subject)

        expect(result.value.id).to eq '5jy9hcMeEgQ4maKGqIOYW6'
        expect(result.value.title).to eq 'My Title'
        expect(result.value.calories).to eq 450
      end

      it 'should parse the photo url' do
        result = Recipes::FormatService.call(subject)

        expect(result.value.image_url).to eq 'https://somephoto.to.recipe.com/image.jpg'
      end

      it 'should parse the chef name' do
        result = Recipes::FormatService.call(subject)

        expect(result.value.chef).to eq 'Recipe Chef'
      end

      it 'should parse each tags name' do
        result = Recipes::FormatService.call(subject)

        expect(result.value.tags).to eq ['delightful', 'Tag 1', 'Tag 2']
      end

      it 'should parse the description' do
        result = Recipes::FormatService.call(subject)

        parsed = <<~PARSED
          <p><em>Recipe 101</em>: This is my <strong>recipe</strong>.
          Check the instructions <a href=\"https://somelink.to.video.com\">video</a></p>
        PARSED

        expect(result.value.description).to eq parsed
      end
    end

    context 'with missing params' do
      subject do
        OpenStruct.new(
          id: '5jy9hcMeEgQ4maKGqIOYW6',
          title: 'My Title',
          calories: 450,
          photo: nil,
          chef: nil,
          tags: [],
          description: 'desc'
        )
      end

      it 'should parse the default photo url' do
        result = Recipes::FormatService.call(subject)

        expect(result.value.image_url).to eq 'https://via.placeholder.com/1020x680'
      end

      it 'should parse the default chef name' do
        result = Recipes::FormatService.call(subject)

        expect(result.value.chef).to eq 'Delightful Recipes'
      end

      it 'should parse the default tags' do
        result = Recipes::FormatService.call(subject)

        expect(result.value.tags).to eq ['delightful']
      end
    end
  end

  context 'collection' do
    context 'with all params' do
      subject do
        [
          OpenStruct.new(
            id: '5jy9hcMeEgQ4maKGqIOYW6',
            title: 'My Title',
            calories: 450,
            photo: OpenStruct.new(url: 'https://somephoto.to.recipe.com/image.jpg'),
            chef: OpenStruct.new(name: 'Recipe Chef'),
            tags: [OpenStruct.new(name: 'Tag 1')],
            description: 'Description'
          )
        ]
      end

      before :each do
        allow(subject).to receive(:is_a?).and_return(true)
      end

      it 'should be an instance of Array' do
        result = Recipes::FormatService.call(subject)

        expect(result.value.class).to eq Array
      end

      it 'should parse the photo url' do
        result = Recipes::FormatService.call(subject)

        expect(result.value.first.image_url).to eq 'https://somephoto.to.recipe.com/image.jpg'
      end

      it 'should parse the chef name' do
        result = Recipes::FormatService.call(subject)

        expect(result.value.first.chef).to eq 'Recipe Chef'
      end

      it 'should parse each tags name' do
        result = Recipes::FormatService.call(subject)

        expect(result.value.first.tags).to eq ['delightful', 'Tag 1']
      end

      it 'should parse the description' do
        result = Recipes::FormatService.call(subject)

        expect(result.value.first.description).to eq "<p>Description</p>\n"
      end
    end
  end
end
