# frozen_string_literal: true

RSpec.describe Common::Message do
  describe "#initialize" do
    context "with string argument" do
      subject(:message) { described_class.new("Hello, world!") }

      it "sets role to system" do
        expect(message.role).to eq("system")
      end

      it "sets content to the argument" do
        expect(message.content).to eq("Hello, world!")
      end
    end

    context "with hash argument" do
      subject(:message) { described_class.new(role: "user", content: "Hello, world!", name: "test") }

      it "sets role to the argument" do
        expect(message.role).to eq("user")
      end

      it "sets content to the argument" do
        expect(message.content).to eq("Hello, world!")
      end

      it "sets name to the argument" do
        expect(message.name).to eq("test")
      end
    end

    context "with JSON content" do
      subject(:message) { described_class.new(content: '{"agent": { "code": "007"} }') }

      it "parses the JSON content" do
        expect(message.content).to eq({ agent: { code: "007" } })
      end
    end
  end
end
