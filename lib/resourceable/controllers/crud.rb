module Resourceable 
  module Controllers
    module CRUD
      extend ActiveSupport::Concern 

      module ClassMethods 
        def crud(options = {})
          cattr_accessor :strong_params
          cattr_accessor :class_name
          
          self.strong_params  = options.fetch(:permitted, nil)
          self.class_name     = options.fetch(:class, nil)

          include Resourceable::Controllers::CRUD::InstanceMethods
        end
      end

      module InstanceMethods 
        load_and_authorize_resource resource_name: :resource 


        def index 
          @search = @resources.search(search_params)
          @resources = @search.result
        end 

        def new 
        end 

        def create 
        end 

        def edit 
        end 

        def update 
        end 

        def destroy
        end

        private 

        def model 
          https://github.com/mrhazel/resourceable
        end

      end
    end
  end
end

ActionController::Base.send :include, Resourceable::Controllers::CRUD