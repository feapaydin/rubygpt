# frozen_string_literal: true

RSpec.describe Rubygpt::Client::Configuration do
  describe ".from" do
    shared_examples "configuration creator" do
      it "returns a new Configuration object" do
        expect(response).to be_a(described_class)
      end

      it "sets the correct attribute values" do
        expect(response.api_key).to eq(configuration_input[:api_key])
        expect(response.api_url).to eq(configuration_input[:api_url])
        expect(response.model).to eq(configuration_input[:model])
        expect(response.organization_id).to eq(configuration_input[:organization_id])
        expect(response.connection_adapter).to eq(configuration_input[:connection_adapter])
      end
    end

    let(:configuration_input) { { model: "gpt-4-nondefault", api_url: "https://api.openai.com/non/default/url", api_key: "api_key", organization_id: "organization_id", connection_adapter: :non_faraday } }
    subject(:response) { described_class.from(configuration_input) }

    context "with a Hash" do
      it_behaves_like "configuration creator"
    end

    context "with a Configuration object" do
      subject(:response) { described_class.from(described_class.new(configuration_input)) }
      it_behaves_like "configuration creator"
    end

    context "with nil" do
      let(:configuration_input) { nil }

      it "retuns empty configuration with only defaults" do
        expect(response.api_url).to eq(described_class::DEFAULT_API_URL)
        expect(response.connection_adapter).to eq(described_class::DEFAULT_CONNECTION_ADAPTER)
        expect(response.organization_id).to be_nil
        expect(response.api_key).to be_nil
      end
    end

    context "with an invalid input" do
      let(:configuration_input) { 123 }

      it "raises an error" do
        expect { response }.to raise_error(described_class::InvalidConfigurationError)
      end
    end

    context "when optional fields are missing" do
      let(:configuration_input) { { model: "gpt-4-nondefault", api_key: "api_key" } }

      it "applies defaults" do
        expect(response.api_url).to eq(described_class::DEFAULT_API_URL)
        expect(response.connection_adapter).to eq(described_class::DEFAULT_CONNECTION_ADAPTER)
        expect(response.organization_id).to be_nil
      end
    end
  end
end
