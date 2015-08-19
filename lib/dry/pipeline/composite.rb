module Dry
  module Pipeline
    class Composite
      attr_reader :left
      attr_reader :right

      # @api private
      def initialize(left, right)
        @left = left
        @right = right
      end

      def call(value)
        right.(left.(value))
      end
      alias_method :[], :call

      def >>(other)
        self.class.new(self, other)
      end
    end
  end
end
