module Dry
  class Pipeline
    module Mixin
      def >>(other)
        ::Dry::Pipeline::Composite.new(self, other)
      end
    end
  end
end
