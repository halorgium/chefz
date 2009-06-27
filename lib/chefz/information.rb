module Information
  def data
    @data ||= {}
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
