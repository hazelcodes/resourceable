module Resourceable  
  # simple_form might not play nice with namespaced inputs, we'll find out.
  module Inputs
    class HasManyInput < SimpleForm::Inputs::Base 
      # f.input :subscriptions, as: :has_many

      def input 
        output = ActiveSupport::SafeBuffer.new 

        output << @builder.simple_fields_for(attribute_name )do |ff|
          ff.input(:id, as: :hidden) + build_inputs(ff).join.html_safe
        end
        output
      end

      private 

      def building_on 
        @builder.object
      end

      def association_class
        building_on.class.reflect_on_association(attribute_name).class_name.safe_constantize
      end
      
      def association_attributes 
        association_class.attribute_names.map(&:to_sym) - (association_class.try(:skipped_inputs) || [])
      end

      def build_inputs(form_object)
        association_attributes.map do |association_name|
          form_object.input association_name
        end
      end
    end
  end
end