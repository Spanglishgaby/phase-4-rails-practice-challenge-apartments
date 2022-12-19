class LeaseSerializer < ActiveModel::Serializer
  attributes :id, :rent
  has_one :apartment
  has_one :tenant
end
