module Chefz
  class Node
    def self.run(recipes, directory)
      new(recipes, directory).run
    end

    def initialize(recipes, directory)
      @recipes, @directory = recipes, directory
    end

    def run
      load_resources
      load_recipes
      run_resources
      self
    end

    def load_resources
      filename = File.dirname(__FILE__) + "/information.rb"
      resources_klass.module_eval(File.read(filename), filename, 1)
      Dir.glob(@directory + "/resources/**/*.rb").each do |filename|
        resources_klass.module_eval(File.read(filename), filename, 1)
      end
    end

    def load_recipes
      missing = @recipes - available_recipes
      if missing.any?
        raise "Could not find missing recipes: #{missing.inspect}"
      end
      @recipes.each do |name|
        resources.instance_eval(File.read(@directory + "/recipes/#{name}.rb"), "(recipe: #{name})", 1)
      end
    end

    def run_resources
      information_module.resources.each do |resource|
        resource.run
      end
    end

    def data
      information_module.data
    end

    def resources_klass
      @resources_klass ||= Class.new(Resources)
    end

    def information_module
      @information_module ||= resources_klass.const_get(:Information)
    end

    def resources
      @resources ||= resources_klass.new(self)
    end

    def available_recipes
      @available_recipes ||= begin
        Dir.chdir(@directory + "/recipes") do
          Dir.glob("**/*.rb").map {|f| f[0..-4]}
        end
      end
    end
  end
end
