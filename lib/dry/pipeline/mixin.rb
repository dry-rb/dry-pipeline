module Dry
  class Pipeline
    module Mixin
      attr_reader :fn

      def initialize(fn, *)
        @fn = fn
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
