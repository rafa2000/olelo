description  'Footnote support'
dependencies 'filter/tag'

Tag.define :ref, :description => 'Create footnote' do |context, attrs, content|
  footnotes = context.private[:footnotes] ||= []
  hash = context.private[:footnotes_hash] ||= {}
  name = attrs['name']
  if content.blank?
    raise(ArgumentError, 'Attribute name missing') if name.blank?
    raise(NameError, "Footnote #{name} not found") if !hash.include?(name)
    note_id = hash[name]
    ref_id = "#{note_id}_#{footnotes[note_id-1][2].size + 1}"
    footnotes[note_id-1][2] << ref_id
  else
    note_id = ref_id = footnotes.size + 1
    content = subfilter(nested_tags(context.subcontext, content))
    footnotes << [note_id, content.gsub(/^\s*<p>\s*|\s*<\/p>\s*$/, ''), [ref_id]]
    hash[name] = note_id if !name.blank?
  end
  %{<a class="ref" id="ref#{ref_id}" href="#note#{note_id}">[#{note_id}]</a>}
end

Tag.define :references, :description => 'Print all footnotes' do |context, attrs, content|
  footnotes = context.private[:footnotes]
  render :footnotes, :locals => {:footnotes => footnotes} if footnotes
end

__END__

@@ footnotes.haml
%ol
  - footnotes.each do |id, note, refs|
    %li(id="note#{id}")
      - refs.each do |ref|
        %a.backref(href="#ref#{ref}") ↑
      = note
