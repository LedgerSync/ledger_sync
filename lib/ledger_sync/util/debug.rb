# frozen_string_literal: true

def pdb(thing = nil, backtrace_offset: 0, **keywords)
  backtrace_line = caller[backtrace_offset].split(':')[0..1].join(':')
  thing = keywords if thing.eql?(nil) && keywords.any?
  thing = thing.inspect unless thing.is_a?(String)

  puts(
    (
      'PDB' + ': ' + thing
    ).colorize(color: :black, background: :light_white) +
      " @ #{backtrace_line}".colorize(color: :blue, background: :light_white)
  )
  puts "\n"
  thing
end
