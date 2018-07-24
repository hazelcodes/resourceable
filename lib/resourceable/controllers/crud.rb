module Resourceable 
  module Controllers
    module CRUD
      extend ActiveSupport::Concern 

      module ClassMethods 
        def crud(options = {})
          cattr_accessor :strong_params
          cattr_accessor :cancan_options
          cattr_accessor :search_param
          cattr_accessor :pagination_params
          
          self.strong_params      = options.fetch(:permitted, [])
          self.cancan_options     = options.fetch(:cancan, {})
          self.search_param       = options.fetch(:q, :q)
          self.pagination_params  = pagination_defaults.merge(options.fetch(:pagination, {}))
          

          include Resourceable::Controllers::CRUD::InstanceMethods
        end

        private 

        def pagination_defaults 
          { param: :page, per: 20 }
        end
      end
      
      module InstanceMethods 
        extend ActiveSupport::Concern 

        included do 
          respond_to :html, :json

          load_and_authorize_resource self.cancan_options
        end

        with_options to: :cancan_resource, prefix: false do |controller|
          controller.delegate :collection_instance, :collection_instance=, 
                              :resource_instance, :resource_instance=,
                              :instance_name
        end
        
        def index 
          @search = collection_instance.search(search_params)
          collection_instance! @search.result.page(page_params).per(pagination.per)
          respond_with collection_instance
        end 

        def show 
          respond_with resource_instance
        end

        def new 
        end 

        def create 
          resource_instance.save
          respond_with resource_instance
        end 

        def edit 
        end 

        def update 
          resource_instance.update_attributes(resource_params) 
          respond_with resource_instance
        end 

        def destroy
          resource_instance.destroy 
          respond_with resource_instance
        end

        private 

        def flash_interpolation_options
          { resource_name: resource_instance.class.to_s }
        end

        def page_params 
          params.fetch(pagination.param, nil)
        end

        def search_params 
          params.fetch(self.class.search_param, {})
        end

        def resource_params 
          params.require(instance_name.to_sym).permit(self.class.strong_params)
        end

        def pagination 
          OpenStruct.new(self.class.pagination_params)
        end

        protected 

        def cancan_resource 
          @cancan ||= self.class.cancan_resource_class.new(self)
        end

        def collection_instance!(collection)
          send(:collection_instance=, collection)
        end

        def resource_instance!(resource)
          send(:resource_instance=, resource)
        end

      end
    end
  end
end

ActionController::Base.send :include, Resourceable::Controllers::CRUD