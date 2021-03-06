module Chefz
  class Resource
    def initialize(name, action, &block)
      unless self.class.valid_actions.include?(action)
        raise "#{action.inspect} is not a valid action for #{self.class}"
      end
      @name, @action = name, action
      if block_given?
        instance_eval(&block)
      end
    end

    def run
      send(@action)
    end

    def self.actions(*actions)
      @actions = actions
      actions.each do |name|
        create_action(name.to_sym)
      end
    end

    def self.create_action(name)
      @created_actions ||= []
      if methods.include?(name.to_s)
        raise "Cannot create action called #{name.inspect}, already a method"
      end
      return if @created_actions.include?(name)
      @created_actions << name
      class_eval <<-EOT
        def self.#{name}(name, &block)
          @@information.resources << new(name, #{name.inspect}, &block)
        end
      EOT
    end


    def self.valid_actions
      @actions || []
    end

    def self.attribute(name, options = {})
      attributes[name] = options
      create_attribute name
    end

    def self.create_attribute(name)
      class_eval <<-EOT
        def #{name}(value = nil)
          if value.nil?
            @#{name}
          else
            @#{name} = value
          end
        end
      EOT
    end

    def self.attributes
      @attributes ||= {}
    end

    attribute :name
  end
end
