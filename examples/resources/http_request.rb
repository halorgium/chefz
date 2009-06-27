class HTTPRequest < Resource
  actions :make

  def make
    puts "Making http request to #{name}"
  end
end
