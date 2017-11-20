module Resourceable  
  # simple_form might not play nice with namespaced inputs, we'll find out.
  module Inputs
    class HasManyInput < SimpleForm::Inputs::Base 
      # f.input :subscriptions, as: :has_many

      def input 
        @builder.simple_fields_for attribute_name do |ff|
          association_attributes.each do |association_name|
            f.input association_name
          end
        end
      end

      private 

      def building_on 
        @builder.object
      end

      def association_class
        building_on.reflect_on_association(attribute_name).class_name.safe_constantize
      end
      
      def association_attributes 
        association_class.attribute_names.map(&:to_sym)
      end
    end
  end
end