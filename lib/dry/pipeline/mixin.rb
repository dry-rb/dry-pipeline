module Dry
  class Pipeline
    module Mixin
      attr_reader :fn

      def initialize(fn = nil, *, &block)
        @fn = block_given? ? block : fn
      end

      def call(input)
        fn.(input)
      end

      def >>(other)
        ::Dry::Pipeline::Composite.new(self, other)
      end
    end
  end
end
