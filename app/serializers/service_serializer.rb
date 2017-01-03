class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :service_name, :description, :price, :start_time, :end_time, :slug
end
