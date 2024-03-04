# frozen_string_literal: true

RSpec.describe Rubygpt do
  it "has a version number" do
    expect(Rubygpt::VERSION).not_to be nil
  end

  describe ".configure" do
    it "can configure the default client with a block" do
      Rubygpt.configure do |config|
        config.api_key = "api-key-block"
        config.model = "model-block"
        config.organization_id = "organization-id-block"
      end
      client_config = Rubygpt.instance_variable_get(:@default_client).configuration
      expect(client_config.api_key).to eq("api-key-block")
      expect(client_config.model).to eq("model-block")
      expect(client_config.organization_id).to eq("organization-id-block")
    end

    it "can configure the default client with a hash" do
      Rubygpt.configure(api_key: "api-key-hash", model: "model-hash", organization_id: "organization-id-hash")
      client_config = Rubygpt.instance_variable_get(:@default_client).configuration
      expect(client_config.api_key).to eq("api-key-hash")
      expect(client_config.model).to eq("model-hash")
      expect(client_config.organization_id).to eq("organization-id-hash")
    end
  end

  describe ".chat" do
    it "returns a ChatRequester object" do
      expect(Rubygpt.chat).to be_a(Rubygpt::Requester::ChatRequester)
      expect(Rubygpt.chat.client).to eq(Rubygpt.instance_variable_get(:@default_client))
    end
  end
end
