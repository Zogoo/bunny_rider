class BunnySender
  attr_accessor :client, :channel, :queue, :exchange

  def initialize(config = {})
    self.client = Bunny.new(default_config.merge(config))
  end

  def open_connection
    client.start
  end

  def call_back
    queue.subscribe do |_delivery_info, _metadata, payload|
      yield(_delivery_info, _metadata, payload)
    end
  end

  def close_connection
    client.close
  end

  def send_message(queue_name, object)
    exchange.publish('Hello!', routing_key: queue.name)
  end

  def add_channel(name = '', options = {})
    self.channel = client.create_channel
    self.queue  = channel.queue(name, options)
    self.exchange  = channel.default_exchange
  end

  def send_test
    STDOUT.sync = true
    client.start

    add_channel('bunny.examples.hello_world', auto_delete: true)
    queue.subscribe do |_delivery_info, _metadata, payload|
      puts "Received #{payload}"
    end
    exchange.publish('Hello!', routing_key: queue.name)

    sleep 1.0
    client.close
  end

  private

  def default_config
    {
      host: '127.0.0.1',
      port: 5672,
      ssl: false,
      vhost: '/',
      user: 'skuid',
      pass: 'someeasierpass',
      heartbeat: :server, # will use RabbitMQ setting
      frame_max: 131_072,
      auth_mechanism: 'PLAIN'
    }
  end
end
