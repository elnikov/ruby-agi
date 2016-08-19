# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby-agi}
  s.version = "1.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mohammad Khan", "Carlos Lenz", "Eric Richmond"]
  s.date = %q{2009-08-11}
  s.description = %q{Work fork version}
  s.email = %q{elnikov.s@gmail.com}
  s.extra_rdoc_files = [
    "ChangeLog",
     "LICENSE",
     "README.md"
  ]
  s.files = [
    "ChangeLog",
     "LICENSE",
     "README.md",
     "Rakefile",
     "VERSION",
     "examples/call_log.rb",
     "lib/ruby-agi.rb",
     "lib/ruby-agi/agi.rb",
     "lib/ruby-agi/asterisk_variable.rb",
     "lib/ruby-agi/command.rb",
     "lib/ruby-agi/error.rb",
     "lib/ruby-agi/return_status.rb",
     "lib/ruby-agi/rs/answer.rb",
     "lib/ruby-agi/rs/channel_status.rb",
     "lib/ruby-agi/rs/exec.rb",
     "lib/ruby-agi/rs/get_variable.rb",
     "lib/ruby-agi/rs/hangup.rb",
     "lib/ruby-agi/rs/noop.rb",
     "lib/ruby-agi/rs/receive_char.rb",
     "lib/ruby-agi/rs/receive_text.rb",
     "lib/ruby-agi/rs/record_file.rb",
     "lib/ruby-agi/rs/result.rb",
     "lib/ruby-agi/rs/return_status.rb",
     "lib/ruby-agi/rs/say_digits.rb",
     "lib/ruby-agi/rs/say_number.rb",
     "lib/ruby-agi/rs/say_phonetic.rb",
     "lib/ruby-agi/rs/say_time.rb",
     "lib/ruby-agi/rs/send_image.rb",
     "lib/ruby-agi/rs/send_text.rb",
     "lib/ruby-agi/rs/set_auto_hangup.rb",
     "lib/ruby-agi/rs/set_caller_id.rb",
     "lib/ruby-agi/rs/set_context.rb",
     "lib/ruby-agi/rs/set_extension.rb",
     "lib/ruby-agi/rs/set_music.rb",
     "lib/ruby-agi/rs/set_priority.rb",
     "lib/ruby-agi/rs/set_variable.rb",
     "lib/ruby-agi/rs/stream_file.rb",
     "lib/ruby-agi/rs/tdd_mode.rb",
     "lib/ruby-agi/rs/verbose.rb",
     "lib/ruby-agi/rs/wait_for_digit.rb",
     "lib/ruby-agi/rs/wait_for_digits.rb",
     "ruby-agi.gemspec"
  ]
  s.homepage = %q{https://github.com/elnikov/ruby-agi}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Ruby AGI interface into Asterisk}
  s.test_files = [
    "examples/call_log.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
