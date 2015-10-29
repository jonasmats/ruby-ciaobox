class Profile::ChangePassword
  attr_reader :resource, :current_password, :new_password, :confirm_password
  
  def initialize(resource, hash_password)
    @resource = resource
    @current_password = hash_password[:current]
    @new_password = hash_password[:new]
    @confirm_password = hash_password[:confirm]
  end

  def current_match?
    @resource.valid_password? @current_password
  end

  def confirm_match?
    @new_password == @confirm_password
  end

  def change
    @resource.update(password: @confirm_password)
  end
end