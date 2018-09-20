class BunnyTopic < BunnySender

  def send_test
    open_connection

    channel  = client.create_channel
    # topic exchange name can be any string
    exchange = channel.topic("weathr", :auto_delete => true)
    byebug
    # Subscribers.
    a = channel.queue("", :exclusive => true)
    b = a.bind(exchange, :routing_key => "americas.north.#")
    b.subscribe do |delivery_info, metadata, payload|
      puts "An update for North America: #{payload}, routing key is #{delivery_info.routing_key}"
    end
    a = channel.queue("americas.south")
    b = a.bind(exchange, :routing_key => "americas.south.#")
    b.subscribe do |delivery_info, metadata, payload|
      puts "An update for South America: #{payload}, routing key is #{delivery_info.routing_key}"
    end
    byebug
    channel.queue("us.california").bind(exchange, :routing_key => "americas.north.us.ca.*").subscribe do |delivery_info, metadata, payload|
      puts "An update for US/California: #{payload}, routing key is #{delivery_info.routing_key}"
    end
    channel.queue("us.tx.austin").bind(exchange, :routing_key => "#.tx.austin").subscribe do |delivery_info, metadata, payload|
      puts "An update for Austin, TX: #{payload}, routing key is #{delivery_info.routing_key}"
    end
    channel.queue("it.rome").bind(exchange, :routing_key => "europe.italy.rome").subscribe do |delivery_info, metadata, payload|
      puts "An update for Rome, Italy: #{payload}, routing key is #{delivery_info.routing_key}"
    end
    channel.queue("asia.hk").bind(exchange, :routing_key => "asia.southeast.hk.#").subscribe do |delivery_info, metadata, payload|
      puts "An update for Hong Kong: #{payload}, routing key is #{delivery_info.routing_key}"
    end

    exchange.publish("San Diego update", :routing_key => "americas.north.us.ca.sandiego").
      publish("Berkeley update",         :routing_key => "americas.north.us.ca.berkeley").
      publish("San Francisco update",    :routing_key => "americas.north.us.ca.sanfrancisco").
      publish("New York update",         :routing_key => "americas.north.us.ny.newyork").
      publish("São Paulo update",        :routing_key => "americas.south.brazil.saopaulo").
      publish("Hong Kong update",        :routing_key => "asia.southeast.hk.hongkong").
      publish("Kyoto update",            :routing_key => "asia.southeast.japan.kyoto").
      publish("Shanghai update",         :routing_key => "asia.southeast.prc.shanghai").
      publish("Rome update",             :routing_key => "europe.italy.rome").
      publish("Paris update",            :routing_key => "europe.france.paris")

    sleep 1.0

    client.close
  end
end
