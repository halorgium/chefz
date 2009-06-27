class HTTPRequest < Chefz::Resource
  actions :make

  def make
    puts "Making http request to #{name}"
  end
end
