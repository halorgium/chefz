class RackApp < PassengerApp
  actions :deploy

  attribute :hostname

  def deploy
    puts "deploying rack app: #{name} to #{hostname}"
  end
end
