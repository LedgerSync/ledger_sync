# frozen_string_literal: true

require_relative 'template'

module Docs
  class Generator
    module Methods
      def clear_dir(path, except: [])
        dir_path = docs_path(path)
        yellow "Clearing: #{dir_path}"
        Dir.foreach(dir_path) do |f|
          next if except.include?(f)

          fn = File.join(dir_path, f)
          next if f == '.'
          next if f == '..'

          rm(fn)
        end
        green "Cleared: #{dir_path}"
        nl
      end

      def cp(src, dest, *)
        yellow "Copying #{src} to #{dest}"
        FileUtils.cp_r(src, dest, *)
        green "Copied #{src} to #{dest}"
        nl
      end

      def destination_path(*, **keywords)
        docs_path(*, format: :md, **keywords)
      end

      def docs_path(*path, format: nil)
        path = path.map(&:to_s)

        File.join(
          docs_root_path,
          *path[0..-2],
          [path.last, format].flatten.compact.join('.')
        )
      end

      def docs_root_path
        @docs_root_path ||= ENV.fetch('DOCS_ROOT_PATH', File.join(__dir__, '../site'))
      end

      def ledgers
        LedgerSync.ledgers
                  .to_a
                  .map(&:last)
                  .uniq
                  .to_a
                  .sort_by(&:root_key)
      end

      def rm(filename)
        yellow "Removing: #{filename}"
        FileUtils.rm_rf(filename, secure: true)
        green "Removed: #{filename}"
        nl
      end

      def template_path(*path, format: :md)
        path = path.map(&:to_s)

        File.join(
          docs_root_path,
          '_templates',
          *path[0..-2],
          "#{path.last}.#{format}.erb"
        )
      end
    end

    include Methods
    extend Methods
  end
end
