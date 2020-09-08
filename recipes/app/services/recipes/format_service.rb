# frozen_string_literal: true

require 'github/markup'

module Recipes
  class FormatService < ApplicationService
    def initialize(to_format)
      @to_format = to_format
    end

    def call
      Result.new(true, nil, format_recipes)
    rescue StandardError => e
      Result.new(false, e, nil)
    end

    private

    attr_accessor :to_format

    def format_recipes
      if to_format.is_a?(Contentful::Array)
        format_collection
      else
        format_record(to_format)
      end
    end

    def format_record(recipe)
      OpenStruct.new(
        {
          id: recipe.id,
          title: recipe.title,
          calories: recipe.calories,
          description: description(recipe),
          image_url: image_url(recipe),
          chef: chef(recipe),
          tags: tags(recipe)
        }
      )
    end

    def format_collection
      to_format.map { |recipe| format_record(recipe) }
    end

    def description(recipe)
      GitHub::Markup.render('README.markdown', recipe.description)
    end

    def image_url(recipe)
      recipe&.photo&.url || 'https://via.placeholder.com/1020x680'
    end

    def chef(recipe)
      recipe&.chef&.name || 'Delightful Recipes'
    end

    def tags(recipe)
      recipe.tags.map(&:name).prepend('delightful')
    end
  end
end
