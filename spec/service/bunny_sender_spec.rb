# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BunnySender do
  describe '.send_test' do
    context 'when create new sender' do
      let(:sender) { described_class.new }
      before do
        sender.send_test
      end

      it 'will send message' do
      end
    end
  end
end
