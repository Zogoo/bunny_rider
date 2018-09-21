# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BunnyTopic do
  describe 'send with routing key' do
    context 'send message with router' do
      let(:router) { described_class.new }
      it 'will send without error' do
        expect do
          router.send_test
        end.not_to raise_error
      end
    end
  end
end
