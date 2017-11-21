module Resourceable  
  # simple_form might not play nice with namespaced inputs, we'll find out.
  module Inputs
    class HasManyInput < SimpleForm::Inputs::Base 
      def input 
        output = ActiveSupport::SafeBuffer.new 

        output << @builder.simple_fields_for(attribute_name )do |ff|
          ff.input(:id, as: :hidden) + build_inputs(ff)
        end

        output
      end

      private 

      def partial 
        options.fetch(:partial, nil)
      end

      def action_view 
        @action_view ||= ActionView::Base.new(ActionController::Base.view_paths, {})
      end

      def build_inputs(form_object)
        action_view.render(partial: partial, locals: { form_object: form_object }).html_safe
      end
    end
  end
end