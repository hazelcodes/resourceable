module Resourceable 
  module Controllers
    module CRUD
      extend ActiveSupport::Concern 

      module ClassMethods 
        def crud(options = {})
          cattr_accessor :strong_params
          cattr_accessor :cancan_options
          cattr_accessor :search_param
          
          self.strong_params  = options.fetch(:permitted, [])
          self.cancan_options = options.fetch(:cancan, {})
          self.search_param   = options.fetch(:q, :q)

          include Resourceable::Controllers::CRUD::InstanceMethods
        end
      end
      
      module InstanceMethods 
        load_and_authorize_resource self.cancan_options

        def index 
          @search = collection_instance.search(search_params)
          collection_instance = @search.result
        end 

        def new 
        end 

        def create 
          if resource_instance.save
            # flash messages and shit
          else 

          end
        end 

        def edit 
        end 

        def update 
        end 

        def destroy
        end

        private 

        def search_params 
          params.permit(self.class.search_param)
        end

        def resource_params 
          params.require(instance_name.to_sym).permit(self.class.strong_params)
        end
      end
    end
  end
end

ActionController::Base.send :include, Resourceable::Controllers::CRUD