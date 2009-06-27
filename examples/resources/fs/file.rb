require 'fileutils'

module FS
  class File < Chefz::Resource
    actions :create, :delete, :touch

    attribute :backup, :default => 5
    attribute :group
    attribute :mode
    attribute :owner
    attribute :path, :default => Proc.new {|file| file.name}

    def touch
      ::FileUtils.touch(name)
    end
  end
end
