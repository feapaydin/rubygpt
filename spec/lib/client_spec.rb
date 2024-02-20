# frozen_string_literal: true

RSpec.describe Rubygpt::Client do
  describe ".new" do
    shared_examples "client generator" do
      it "initializes a new Rubygpt::Client object" do
        expect(response).to be_a(Rubygpt::Client)
        expect(response.configuration.api_key).to eq(configuration[:api_key])
        expect(response.configuration.model).to eq(configuration[:model])
      end

      it "passes the configuration" do
        expect { response.configuration.validate! }.not_to raise_error
      end
    end

    let(:configuration) { { api_key: "api_key", model: "gpt-4" } }

    context "when client directly initialized" do
      subject(:response) { described_class.new(configuration) }
      it_behaves_like "client generator"
    end

    context "when client initialized with a block" do
      subject(:response) do
        described_class.new do |config|
          config.api_key = configuration[:api_key]
          config.model = configuration[:model]
        end
      end
      it_behaves_like "client generator"
    end
  end
end
