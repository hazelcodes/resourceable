module Resourceable 
  module Generators 
    class ResourceGenerator < Rails::Generators::NamedBase 
      # rails g resourceable:resource User email:string password:string

      class_option :attributes, type: :hash, banner: 'hash of model attributes', aliases: ['-a']

      def model
        generate 'model', "#{name} #{attributes_cli_options}"
      end

      def controller 
        generate 'controller', name.titleize.pluralize
        
        puts "app/controllers/#{name.downcase.pluralize}_coontroller.rb"
        puts "#{name.titleize.pluralize}Controller"

        inject_into_class controller_path, controller_name, 
          "\tcrud permitted: #{attribute_keys}\n"    
      end

      private 

      def attributes_cli_options
        options[:attributes].map{ |k,v| "#{k}:#{v}" }.join(' ')
      end

      def attribute_keys
        options[:attributes].symbolize_keys.keys
      end

      def controller_name 
        "#{name.titleize.pluralize}Controller" 
      end

      def controller_path
        "app/controllers/#{name.downcase.pluralize}_controller.rb"
      end
    end
  end
end