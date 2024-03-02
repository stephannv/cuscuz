module Cuscuz
  module Outputable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def output(name, type)
      end
    end
  end
end
