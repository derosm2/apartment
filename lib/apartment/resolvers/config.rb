require 'apartment/resolvers/abstract'

module Apartment
  module Resolvers
    class Config < Abstract
      def resolve(tenant)
        return init_config.dup if !tenant || tenant == Apartment.default_tenant

        database_config(tenant)
      end

      private

      def database_config(tenant)
        ActiveRecord::Base.configurations[config_name(tenant)].symbolize_keys
      end

      def config_name(tenant)
        "#{Rails.env}_#{tenant}"
      end
    end
  end
end
