# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "font_kit"
  spec.version = "0.1.0"
  spec.summary = "Ruby bindings to Rust's font-kit"
  spec.description = "Ruby bindings to font-kit, a cross-platform font loading library written in Rust."
  spec.files = Dir["lib/**/*.rb"].concat(Dir["ext/font_kit_rb/src/**/*.rs"]) << "ext/font_kit_rb/Cargo.toml" << "ext/font_kit_rb/Rakefile" << "README.rdoc"
  spec.extensions = ["ext/font_kit_rb/Rakefile"]
  spec.rdoc_options = ["--main", "README.rdoc", "--charset", "utf-8", "--exclude", "ext/"]
  spec.extra_rdoc_files = ["README.rdoc"]
  spec.authors = ["Mat Sadler"]
  spec.email = ["mat@sourcetagsandcodes.com"]
  spec.homepage = "https://github.com/matsadler/font_kit"
  spec.license = "MIT"

  spec.requirements = ["Rust >= 1.51.0", "libclang"]

  # actually a build time dependency, but that's not an option.
  # rake is probably part of the user's Ruby distribution, but there are some
  # edge cases where it's not, so we need the explict dependency. Rake's API is
  # very stable, and we're only using the basic bits, so any version should
  # work, but getting some install errors on Ruby 3.0.0/gem 3.2.3 if it's not
  # specified or specified as "> 0"
  spec.add_runtime_dependency "rake", "> 1"
end
