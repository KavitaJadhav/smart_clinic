class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :role

  def role
    object.type
  end
end
