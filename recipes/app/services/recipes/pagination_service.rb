# frozen_string_literal: true

module Recipes
  class PaginationService < ApplicationService
    PER_PAGE = 10

    def initialize(page: 1, order: 'sys.updatedAt')
      @page = page
      @order = order
      Recipe.add_entry_mapping
    end

    def call
      Result.new(true, nil, paginate)
    rescue StandardError => e
      Result.new(false, e, nil)
    end

    private

    attr_accessor :page, :order

    def paginate
      Recipe.paginate(page, PER_PAGE, order).load
    end
  end
end
