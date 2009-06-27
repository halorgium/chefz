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
    end

    def load_resources
      Dir.glob(@directory + "/resources/**/*.rb").each do |filename|
        Resources.module_eval(File.read(filename), filename, 1)
      end
      pp Resources.constants
    end

    def load_recipes
      puts "Recipes to run: #{@recipes.inspect}"
      puts "available: #{available_recipes.inspect}"
      missing = @recipes - available_recipes
      if missing.any?
        raise "Could not find missing recipes: #{missing.inspect}"
      end
      @recipes.each do |name|
        resources.instance_eval(File.read(@directory + "/recipes/#{name}.rb"))
      end
      pp resources
    end

    def run_resources
      resources.run
    end

    def resources
      @resources ||= Class.new(Resources).new(self)
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
