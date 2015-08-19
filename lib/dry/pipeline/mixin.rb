module Dry
  module Pipeline
    module Mixin
      attr_reader :fn

      def initialize(fn, *)
        @fn = fn
      end

      def call(input)
        fn.(input)
      end

      def >>(other)
        Composite.new(self, other)
      end
    end
  end
end
