# frozen_string_literal: true

require 'ledger_sync/util/string_helpers'

docs = Dir.glob('*.md').sort!

File.open('../README.md', 'w+') do |output_file|
  docs.each_with_index do |file_path, index|
    next_file_name = docs[index + 1]
    file = File.open(file_path)
    output_file.write(file.read)

    # Two lines between main sections.

    if next_file_name
      space_between_sections = [*("\n" unless next_file_name =~ /^\d{2}_\d{2}/), "\n", "\n"].join
      output_file.write(space_between_sections)
    end
  end
end

# Table of content creator
File.open('../README.md', 'r+') do |readme_file|
  toc = {}

  updated_lines = readme_file.readlines.map do |line|
    next line unless line =~ /^\#{1,6}\s(\w|\s)*\n/

    name = line.match((/\s[\w|\s]*/))[0]

    throw 'Invalid Name Format' unless name

    name.strip!.downcase!

    link_name = name.split(/\s/).reduce do |final, part|
      part.capitalize
      final << part.capitalize
    end

    if toc.key? link_name
      #  increment last two digits for duplicate
      while toc.key? link_name
        link_name = toc[link_name]

        last_digits =
          begin
            Integer(link_name[-2..-1])
          rescue StandardError
            0
          end&.next

        link_name = (last_digits > 1 ? link_name[0...-2] : link_name) << format('%02d', last_digits.to_s)
      end
    end

    toc[link_name] = link_name

    # Add tag for TOC
    pp "<a name=\"#{link_name}\" />\n\n#{line}"
  end

  # TODO: make table of content

  readme_file.write(updated_lines.join)
end
