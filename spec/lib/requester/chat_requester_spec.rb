# frozen_string_literal: true

RSpec.describe Rubygpt::Requester::ChatRequester do
  let(:client) { Rubygpt::Client.new(api_key: "api-key", model: "gpt-4") }
  let(:chat_requester) { described_class.new(client) }

  describe "#create" do
    subject(:response) { chat_requester.create(create_args) }

    before do
      api_response = Rubygpt::Response::StandardApiResponse.new(status: 200, body: {}, headers: {})
      allow(client).to receive(:post).and_return(api_response)
    end

    context "with string argument" do
      let(:create_args) { "Hello, world!" }

      it "calls client.post with the correct arguments" do
        response
        expected_request_body = { model: "gpt-4", messages: [{ role: "system", content: "Hello, world!" }] }
        expect(client).to have_received(:post).with(chat_requester.api_endpoint, expected_request_body)
      end

      it "returns a ChatResponse" do
        expect(response).to be_a(Rubygpt::Response::ChatResponse)
      end
    end
  end

  describe "#create_request_body" do
    subject(:request_body) { chat_requester.send(:create_request_body, { messages: ["test-message"], max_tokens: 5 }) }

    it "appends the model to the request body" do
      expect(request_body[:model]).to eq("gpt-4")
    end

    it "allows request body params to be passed in" do
      expect(request_body[:max_tokens]).to eq(5)
    end
  end

  describe "#messages_from_args" do
    subject(:messages) { chat_requester.send(:messages_from_args, args) }

    context "with string argument" do
      let(:args) { "Hello, world!" }

      it "creates a message with default attributes" do
        expect(messages).to eq([{ content: "Hello, world!", role: "system" }])
      end
    end

    context "with array argument" do
      let(:args) { ["Hello, world!", "How are you?"] }

      it "creates messages for each content with default attributes" do
        expected_messages = [
          { role: "system", content: "Hello, world!" },
          { role: "system", content: "How are you?" }
        ]
        expect(messages).to eq(expected_messages)
      end
    end

    context "with hash argument" do
      context "when messages key present" do
        let(:args) { { messages: ["Hello, world!", "How are you?"] } }

        it "creates messages for each content with default attributes" do
          expected_messages = [
            { role: "system", content: "Hello, world!" },
            { role: "system", content: "How are you?" }
          ]
          expect(messages).to eq(expected_messages)
        end
      end

      context "when messages key not present" do
        let(:args) { { content: "Hello, world!", role: "user" } }

        it "creates a message from hash" do
          expect(messages).to eq([{ content: "Hello, world!", role: "user" }])
        end
      end
    end

    context "with invalid argument" do
      let(:args) { 123 }

      it "raises an ArgumentError" do
        expect { messages }.to raise_error(ArgumentError, "Invalid message data provided")
      end
    end
  end

  describe "Message" do
    describe "#initialize" do
      context "with string argument" do
        subject(:message) { described_class::Message.new("Hello, world!") }

        it "sets role to system" do
          expect(message.role).to eq("system")
        end

        it "sets content to the argument" do
          expect(message.content).to eq("Hello, world!")
        end
      end

      context "with hash argument" do
        subject(:message) { described_class::Message.new(role: "user", content: "Hello, world!", name: "test") }

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
    end
  end
end
