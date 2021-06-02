docs = Dir.glob('*.md').sort!

output_file = File.open('../README.md', 'w+')

docs.each_with_index do |file_path, index|
  next_file_name = docs[index]
  file = File.open(file_path)
  output_file.write(file.read)

  # Two lines between main sections.
  output_file.write([*("\n" unless /^\d{2}_\d{2}/ == next_file_name), "\n"].join)
end

# Table of content creator
