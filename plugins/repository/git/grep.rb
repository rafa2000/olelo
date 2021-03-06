description 'Searching via git-grep'

raise 'Git repository required' if Config.repository.type != 'git'

class Olelo::Application
  get '/search' do
    @matches = {}

    if params[:pattern].to_s.length > 2
      git = Repository.instance.git

      git.git_grep('-z', '-i', '-I', '-3', '-e', params[:pattern], git.branch) do |io|
        while !io.eof?
          begin
            line = git.set_encoding(io.readline)
            line = unescape_backslash(line)
            if line =~ /(.*?)\:(.*)\0(.*)/ && Namespace.find($2) == Namespace.main
              (@matches[$2] ||= '') << $3
            end
          rescue => ex
            logger.error ex
          end
        end
      end rescue nil # git-grep returns 1 if nothing is found

      git.git_ls_tree('-r', '--name-only', 'HEAD') do |io|
        while !io.eof?
          begin
            line = git.set_encoding(io.readline)
            line = unescape_backslash(line).strip
            if Namespace.find(line) == Namespace.main && line =~ /#{params[:pattern]}/i && !@matches[line]
              page = Page.find!(line)
              @matches[line] = page.content.truncate(500) if page.mime.text?
            end
          rescue => ex
            logger.error ex
          end
        end
      end
    end

    render :grep
  end

  private

  def emphasize(s)
    escape_html(s.truncate(500)).gsub(/(#{params[:pattern]})/i, '<b>\1</b>')
  end
end

__END__

@@ grep.haml
- title :search_results.t(:pattern => params[:pattern])
%p= :match.t(:count => @matches.length)
.search
  - @matches.each do |path, content|
    .match
      %h2
        %a.name{:href => path.urlpath}= emphasize(path)
      .content= emphasize(content)
