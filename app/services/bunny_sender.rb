class BunnySender
  attr_accessor :client, :channel, :queue, :exchange

  def initialize(config = {})
    self.client = Bunny.new(default_config.merge(config))
  end

  def send_once(queue_name, message, &block)
    open_connection
    default_exchange(queue_name, shared_queue_option)
    call_back(&block) if block_given?
    send_message(queue_name, message)
    close_connection
  end

  def open_connection
    client.start
  end

  def close_connection
    sleep 0.5
    client.close
  end

  def call_back(&block)
    queue.subscribe do |_delivery_info, _metadata, payload|
      yield(_delivery_info, _metadata, payload)
    end
  end

  def send_message(queue_name, object)
    exchange.publish(object, routing_key: queue_name)
  end

  def default_exchange(queue_name = '', options = {})
    new_channel
    self.exchange  = channel.default_exchange
    self.queue  = channel.queue(queue_name, options)
  end

  def topic_exchange(exchange_name, queue_name, options = {} )
    new_channel
    self.exchange = channel.topic(exchange_name, options.merge(auto_delete: true))
    self.queue = channel.queue(queue_name)
  end

  def fanout_exchange(exchange_name, queue_name, options = {} )
    new_channel
    self.exchange = channel.fanout(exchange_name)
    self.queue  = channel.queue(queue_name, options.merge(auto_delete: true))
  end

  def bind_queues(routing_key)
    self.queue = queue.bind(exchange, routing_key: routing_key)
  end

  def new_channel
    self.channel = client.create_channel
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

  def shared_queue_option
    { :durable => true, :auto_delete => false }
  end

  def temporary_queue_option
    { :exclusive => true, :auto_delete => false }
  end
end
