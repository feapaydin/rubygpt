# RubyGPT

This gem aims to provide an easy-to-use Ruby wrapper for all modules of OpenAI's GPT API. It is designed to be simple and easy to use, while also providing a high level of customization. It is also aiming to work efficiently in Ruby on Rails applications.

## Usage


### Configuration

In order to access the OpenAI APIs, you must configure the rubygpt client with your API key and the preferred ChatGPT model to use. This can be done in the client initialization.

```ruby
# Initialize the client with required attributes
Rubygpt::Client.new(api_key: 'YOUR_API_KEY', model: 'gpt-3.5-turbo')
```

Alternatively, you can provide a block to set the configuration options:

```ruby
Rubygpt::Client.new do |config|
    config.api_key = 'YOUR_API_KEY'
    config.model = 'gpt-3.5-turbo'
end
```

The following attributes can be configured while initializing the client:

- `api_key` (required): Your OpenAI API key
- `model` (required): The model to use for the API requests.
- `api_url`: The base URL for the API requests. The default is `https://api.openai.com/v1`
- `organization_id`: The organization ID to use for the API requests.
- `connection_adapter`: The HTTP connection adapter to use for the API requests. The default is `:faraday`

#### Connection Adapters

The rubygpt client uses [Faraday](https://github.com/lostisland/faraday) to manage HTTP connections. This allows the entire power of Faraday to be used for the API requests, including diverse HTTP adapters and features like streaming.

### Chat Completions API

Chat Completions is a Text Completion feature provided by OpenAI's ChatGPT. It can be used to generate human-like responses to a given prompt. It is one of the core features of the ChatGPT.

See the [OpenAI Chat Completions API documentation](https://platform.openai.com/docs/guides/text-generation/chat-completions-api) and related [Chat API reference](https://platform.openai.com/docs/api-reference/chat/create) for more information.

#### Performing Requests

```ruby
# TODO: Usage sample for Chat api.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/feapaydin/rubygpt. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/feapaydin/rubygpt/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the Rubygpt project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/feapaydin/rubygpt/blob/main/CODE_OF_CONDUCT.md).
