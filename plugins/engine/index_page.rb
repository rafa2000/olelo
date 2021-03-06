description 'Index page engine'
dependencies 'engine/engine'

Application.hook :layout do |name, doc|
  if @resource && @resource.tree?
    doc.css('#menu .action-edit').each do |a|
      a['href'] = action_path(@resource.path/Config.index_page, :edit)
      a['accesskey'] = 'e'
    end
  end
end

Engine.create(:index_page, :priority => 1, :layout => true) do
  def accepts?(resource)
    resource.tree? && Page.find(resource.path/Config.index_page, resource.current? ? nil : resource.tree_version)
  end

  def output(context)
    tree = context.tree
    page = Page.find!(tree.path/Config.index_page, tree.current? ? nil : tree.tree_version)
    engine = Engine.find(page, :layout => true)
    if engine
      engine.cached_output(context.subcontext(:engine => engine, :resource => page))
    else
      %{<span class="error">#{:engine_not_available.t(:page => page.name, :type => "#{page.mime.comment} (#{page.mime})", :engine => nil)}</span>}
    end
  end
end
