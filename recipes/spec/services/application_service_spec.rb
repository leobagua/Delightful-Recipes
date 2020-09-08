# frozen_string_literal: true

require_relative '../spec_helper'

describe ApplicationService do
  context 'Class' do
    it "shouldn't respond to 'call' method as a instance method" do
      expect { ApplicationService.call }.to raise_error(NoMethodError)
    end

    it "shouldn't respond to 'initialize' method with args" do
      expect { ApplicationService.call(1) }.to raise_error(ArgumentError)
    end
  end

  context 'Result' do
    it 'should be a implementation of Struct' do
      expect(ApplicationService::Result.new).to be_a(Struct)
    end

    it 'should respond to success?' do
      expect(ApplicationService::Result.new).to respond_to(:success?)
    end

    it 'should respond to exception' do
      expect(ApplicationService::Result.new).to respond_to(:error)
    end

    it 'should respond to value' do
      expect(ApplicationService::Result.new).to respond_to(:value)
    end
  end
end
