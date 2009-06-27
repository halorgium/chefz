module Chefz
  class CLI
    def self.run(argv)
      new(argv).run
    end

    def initialize(argv)
      @argv = argv.dup
    end

    def run
      if @argv.size == 2
        recipes_list, directory = @argv
        recipes = recipes_list.split(",")
        Node.run(recipes, directory)
      else
        raise "Invalid args: #{@argv.inspect}"
      end
    end
  end
end
