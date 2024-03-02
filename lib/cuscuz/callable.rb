module Cuscuz
  module Callable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def [](**args)
        new(**args).call
      end
    end
  end
end
