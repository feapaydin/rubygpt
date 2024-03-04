# frozen_string_literal: true

require_relative "lib/rubygpt/version"

Gem::Specification.new do |spec|
  spec.name = "rubygpt"
  spec.version = Rubygpt::VERSION
  spec.authors = ["Furkan Enes Apaydin"]
  spec.email = ["feapaydin@gmail.com"]

  spec.summary = "Ruby wrapper for OpenAI's GPT API."
  spec.description = `
    This gem aims to provide an easy-to-use Ruby wrapper for all modules of OpenAI's GPT API.
    It is designed to be simple and easy to use, while also providing a high level of customization.
    It is also aiming to work efficiently in Ruby on Rails applications.`
  spec.homepage = "https://github.com/feapaydin/rubygpt"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/feapaydin/rubygpt"
  spec.metadata["changelog_uri"] = "https://github.com/feapaydin/rubygpt/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
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
end
