module Resourceable 
  module Models 
    class FormBuilder 
      extend ActiveSupport::Concern

      module ClassMethods 
        def skip_input(*attributes)
          cattr_accessor :skipped_inputs 
          self.skipped_inputs = (attributes || []).map(&:to_sym)

          include Resourceable::Models::FormBuilder::InstanceMethods
        end
      end

      module InstanceMethods 
        def skipped_inputs
          self.class.skipped_inputs
        end

        def skipped_input?(attribute_name)
          skipped_inputs.include?(attribute_name.to_sym)
        end
      end
    end 
  end
end

ActiveRecord::Base.send :include, Resourceable::Models::FormBuilder