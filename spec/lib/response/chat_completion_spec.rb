# frozen_string_literal: true

RSpec.describe Rubygpt::Response::ChatCompletion do
  let(:response_choices) do
    [{
      "index": 1,
      "message": {
        "role": "assistant",
        "content": "World"
      },
      "logprobs": nil,
      "finish_reason": "stop"
    }, {
      "index": 0,
      "message": {
        "role": "user",
        "content": "Hello"
      },
      "logprobs": nil,
      "finish_reason": "stop"
    }]
  end
  let(:response_body) do
    {
      "id": "chatcmpl-123",
      "object": "chat.completion",
      "created": 1_677_652_288,
      "model": "gpt-3.5-turbo-0125",
      "system_fingerprint": "fp_44709d6fcb",
      "choices": response_choices,
      "usage": {
        "prompt_tokens": 2,
        "completion_tokens": 2,
        "total_tokens": 4
      }
    }
  end
  let(:api_response) { Rubygpt::Response::StandardApiResponse.new(status: 200, body: response_body, headers: {}) }
  subject(:chat_completion) { described_class.new(api_response) }

  describe "#initialize" do
    it "sets the attributes by parent" do
      expect(chat_completion.api_response).to eq(api_response)
      expect(chat_completion.id).to eq("chatcmpl-123")
      expect(chat_completion.object).to eq("chat.completion")
      expect(chat_completion.created).to eq(1_677_652_288)
    end

    it "builds the choices" do
      expect(chat_completion.choices).to be_an(Array)
      expect(chat_completion.choices.first).to be_a(Rubygpt::Response::ChatCompletion::Choice)
    end

    it "sorts the choices by index" do
      # Sample data contains the first choice with index 1, the second choice with index 0
      expect(chat_completion.choices[0].index).to eq(0)
      expect(chat_completion.choices[1].index).to eq(1)
    end
  end

  describe "#messages" do
    it "returns the messages from the choices" do
      expect(chat_completion.messages).to eq(%w[Hello World])
    end
  end

  describe "#read" do
    it "returns the messages joined by the separator" do
      expect(chat_completion.read(message_separator: "--")).to eq("Hello--World")
    end
  end

  describe "#cost" do
    it "returns the total tokens used" do
      expect(chat_completion.cost).to eq(4)
    end
  end

  describe "#failed?" do
    context "when all choices succeeded" do
      it "returns false" do
        expect(chat_completion).not_to be_failed
      end
    end

    context "when a choice failed" do
      it "returns true" do
        response_choices.first[:finish_reason] = "length"
        expect(chat_completion).to be_failed
      end
    end
  end

  describe "Choice" do
    subject(:choice) { chat_completion.choices.first }

    describe "#initialize" do
      it "convers the message to a Message object" do
        expect(choice.message).to be_a(Common::Message)
        expect(choice.message.role).to eq("user")
        expect(choice.message.content).to eq("Hello")
      end
    end

    describe "#failed?" do
      it "returns true if the finish reason is not 'stop'" do
        expect(choice).not_to be_failed
      end

      it "returns false if the finish reason is 'stop'" do
        choice.instance_variable_set(:@finish_reason, "length")
        expect(choice).to be_failed
      end
    end
  end
end
