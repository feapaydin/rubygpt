# frozen_string_literal: true

RSpec.describe Rubygpt::Connection do
  describe ".new" do
    let(:configuration) { Rubygpt::Client::Configuration.new(connection_adapter: connection_adapter) }
    subject(:response) { described_class.new(configuration) }

    context "when the adapter is valid" do
      let(:connection_adapter) { :faraday }

      it "finds and instantiates related connection adapter" do
        expect(response).to be_a(Rubygpt::Connection::Faraday)
      end
    end

    context "when the adapter is invalid" do
      let(:connection_adapter) { :invalid }

      it "raises an error" do
        expect { response }.to raise_error(Rubygpt::Client::Configuration::InvalidConfigurationError)
      end
    end
  end
end
