module Resourceable 
  module Models 
    module FormBuilder 
      extend ActiveSupport::Concern

      module ClassMethods 
        def skip_input(*attributes)
          cattr_accessor :skipped_inputs 
          self.skipped_inputs = (attributes || []).map(&:to_sym)

          include_once Resourceable::Models::FormBuilder::InstanceMethods
        end

        def hidden_inputs(*attributes)

        end

        private 

        def include_once(module_name)
          unless self.included_modules.include?(module_name)
            include module_name 
          end
        end
      end

      module InstanceMethods 
        extend ActiveSupport::Concern

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