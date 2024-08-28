# frozen_string_literal: true

require_relative "lib/rubygpt/version"

Gem::Specification.new do |spec|
  spec.name = "rubygpt"
  spec.version = Rubygpt::VERSION
  spec.authors = ["Furkan Enes Apaydin"]
  spec.email = ["feapaydin@gmail.com"]

  spec.license = "MIT"

  spec.summary = "Ruby wrapper for OpenAI's ChatGPT APIs."
  spec.description = <<~DESC
    This gem aims to provide an easy-to-use Ruby wrapper for all modules of OpenAI's GPT API.
    It is designed to be simple and easy to use, while also providing a high level of customization.
    It is also aiming to work efficiently in Ruby on Rails applications.
  DESC
  spec.homepage = "https://github.com/feapaydin/rubygpt"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/feapaydin/rubygpt"
  spec.metadata["changelog_uri"] = "https://github.com/feapaydin/rubygpt/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "faraday", "~> 2.9"
  spec.add_dependency "json", "~> 2.7.1"
  spec.add_development_dependency "rspec", "~> 3.13.0"
  spec.add_development_dependency "webmock", "~> 3.23.0"
end
