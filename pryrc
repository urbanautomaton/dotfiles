# vim: ft=ruby

if Gem::Version.new(Pry::VERSION) < Gem::Version.new('0.14')
  Pry.config.should_load_plugins = true

  if Pry.plugins.has_key?("byebug")
    Pry.commands.alias_command 'c', 'continue'
    Pry.commands.alias_command 's', 'step'
    Pry.commands.alias_command 'n', 'next'
    Pry.commands.alias_command 'f', 'finish'
  end
end
