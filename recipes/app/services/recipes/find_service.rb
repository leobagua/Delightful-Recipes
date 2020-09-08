# frozen_string_literal: true

module Recipes
  class FindService < ApplicationService
    def initialize(id)
      @id = id
    end

    def call
      Result.new(true, nil, find)
    rescue StandardError => e
      Result.new(false, e.message, nil)
    end

    private

    attr_accessor :id

    def find
      Recipe.find(id) || raise(StandardError, 'Recipe not found')
    end
  end
end
