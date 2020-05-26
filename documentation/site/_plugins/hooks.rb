# frozen_string_literal: true

Jekyll::Hooks.register :site, :pre_render do |site, _payload|
  site.pages.each do |page|
    page.data['rel_dir'] = File.dirname(page.path)
    page.data['basename'] = File.basename(page.path)
    page.data['filename'] = File.basename(page.path, '.*')
  end
end
