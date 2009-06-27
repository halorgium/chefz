module Chefz
  class Resources
    def initialize(node)
      @node = node
    end

    def self.create_action(name)
      @created_actions ||= []
      return if @created_actions.include?(name)
      @created_actions << name
      class_eval <<-EOT
        def #{name}(definition, name, options = {}, &block)
          resources << definition.new(name, #{name.inspect}, options, &block)
        end
      EOT
    end

    def run
      resources.each do |resource|
        resource.run
      end
    end

    def resources
      @resources ||= []
    end
  end
end
