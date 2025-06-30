# frozen_string_literal: true

require_relative "lib/word_segmentation/version"

Gem::Specification.new do |spec|
  spec.name = "word_segmentation"
  spec.version = WordSegmentation::VERSION
  spec.authors = ["denis"]
  spec.email = ["denisdenis9331@gmail.com"]

  spec.summary = "Word segmentation algorithm implementation"
  spec.description = "Determines if a string can be segmented into words from a dictionary"
  spec.homepage = "https://github.com/denis1011101/word_segmentation"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4.4"

  spec.metadata["allowed_push_host"] = "https://example.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
