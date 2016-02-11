require 'dry/pipeline/composite'
require 'dry/pipeline/mixin'
require 'dry/pipeline/version'

module Dry
  class Pipeline
    include ::Dry::Pipeline::Mixin

    attr_reader :fn

    def initialize(fn = nil, *, &block)
      @fn = block_given? ? block : fn
    end

    def call(input)
      fn.(input)
    end
  end
end
