# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BunnySender do
  let(:test_queu_name) { 'bunny.examples.hello_world' }
  describe '.send_once' do
    context 'when send message to queue at once with call back' do
      let(:sender) { described_class.new }
      it 'will send message without any error' do
        expect do
          STDOUT.sync = true
          sender.send_once(test_queu_name, 'hello!') do |_d, _metadata, payload|
              puts "Received #{payload}"
          end
        end.to_not raise_error
      end
    end
    context 'when send message to queue at once without call back' do
      let(:sender) { described_class.new }
      it 'will send message without any error' do
        expect do
          STDOUT.sync = true
          sender.send_once(test_queu_name, 'hello!')
        end.to_not raise_error
      end
    end
  end
end
