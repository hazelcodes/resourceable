module Resourceable 
  module Generators 
    class InstallGenerator < Rails::Generators::Base 
      # TODO: add options for the various generators
      # things like using bootstrap themes for simple_form or kaminari
      def responders 
        generate 'responders:install'
      end

      def cancan
        generate 'cancan:ability'
      end

      def kaminari 
        generate 'kaminari:config'
        generate 'kaminari:views -e slim'
      end

      def simple_form 
        generate 'simple_form:install'

        inject_into_file 'config/initializers/simple_form.rb', after: '  # config.custom_inputs_namespaces << "CustomInputs"' do 
          "\n\tconfig.custom_inputs_namespaces << 'Resourceable::Inputs'"
        end
      end
    end
  end
end