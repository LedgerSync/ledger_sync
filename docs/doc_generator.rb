# frozen_string_literal: true

def write_all_segments_to_readme(path_to_readme, docs)
  File.open(path_to_readme, 'w+') do |output_file|
    docs.each_with_index do |file_path, index|
      next_file_name = docs[index + 1]
      file = File.open(file_path)
      output_file.write(file.read)

      # Add two line spaces between main sections.
      if next_file_name
        space_between_sections = [*("\n" unless next_file_name =~ /^\d{2}_\d{2}/), "\n", "\n"].join
        output_file.write(space_between_sections)
      end
    end
  end
end

def generate_toc(path_to_readme, toc_insert_line = 11)
  readme_file = File.open(path_to_readme, 'r+')
  toc = {}

  is_code = false

  updated_lines = readme_file.readlines.map do |line|
    is_code = !is_code if line =~ /`${3}/

    next line unless line =~ (/^\#{1,6}\s(\w|\s)*\n/) && !is_code

    name = line.match((/\s[\w|\s]*/))[0]

    throw 'Invalid Name Format' unless name

    link_name = name.strip.downcase.split(/\s/).reduce do |final, part|
      part.capitalize
      final << part.capitalize
    end

    if toc.key? link_name
      #  increment last two digits for duplicate
      while toc.key? link_name
        link_name = toc[link_name][:link_name]

        last_digits =
          begin
            Integer(link_name[-2..-1])
          rescue StandardError
            0
          end&.next

        link_name = (last_digits > 1 ? link_name[0...-2] : link_name) << format('%02d', last_digits.to_s)
      end
    end

    toc[link_name] = {
      link_name: link_name,
      name: name.strip,
      line: line
    }
    # Add tag for TOC
    "<a name=\"#{link_name}\" />\n\n#{line}"
  end
  readme_file.close

  readme_file = File.open(path_to_readme, 'w')

  updated_lines.insert(toc_insert_line, "**Table of Content**\n", *toc.map do |_k, v|
    number_of_tabs = v[:line].split(' ')[0].count('#') - 1
    tabs = "\t" * [number_of_tabs, 0].max
    "#{tabs}- [#{v[:name]}](##{v[:link_name]})\r"
  end, "\n" * 3)

  readme_file.write(updated_lines.join)
end

def make_readme(path_to_docs = __dir__, path_to_readme = File.join(__dir__, '../', 'README.md'))
  docs = Dir.glob("#{path_to_docs}/*.md").sort!
  write_all_segments_to_readme(path_to_readme, docs)
  generate_toc(path_to_readme)
end

make_readme
