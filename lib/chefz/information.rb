module Information
  def data
    {:ip_address => "zozoz"}
  end
  module_function :data

  def resources
    @resources ||= []
  end
  module_function :resources
end

class Resource < Chefz::Resource
  @@information = Information
end
