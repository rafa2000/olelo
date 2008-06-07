git-wiki: because who needs cool names when you use git?
========================================================

git-wiki is a wiki that relies on git to keep pages' history
and [Sinatra][] to serve them.

I wrote git-wiki as a quick and dirty hack, mostly to play with Sinatra.
It turned out that Sinatra is an awesome little web framework and that this hack
isn't as useless as I first though since I now use it daily.

However, it is definitely not feature rich and will probably never be because
I mostly use it as a web frontend for `git`, `ls` and `vim`.

If you want history, search, etc. you should look at other people's [forks][],
especially [al3x][]'s one.


## Install

You need the fellowing gems:

- git (as in `gem install git`)
- BlueCloth
- rubypants

Run `rake bootstrap && ruby git-wiki.rb` and point your browser at <http://0.0.0.0:4567/>. Enjoy!

You may also want to install it as a daemon. To do so, run `rake daemonize` *(only tested on Ubuntu).*


## Quotes

<blockquote>
<p>[...] the first wiki engine I'd consider worth using for my own projects.</p>
<p><cite><a href="http://www.dekorte.com/blog/blog.cgi?do=item&amp;id=3319">Steve Dekorte</a></cite></p>
</blockquote>

<blockquote>
<p>Oh, it looks like <a href="http://atonie.org/2008/02/git-wiki">Git Wiki</a> may be the
starting point for what I need...</p>
<p><cite><a href="http://tommorris.org/blog/2008/03/09#pid2761430">
Tom Morris on "How to build the perfect wiki"</a></cite></p>
</blockquote>

<blockquote>
<p>Numerous people have written diff and merge systems for wikis; TWiki even uses RCS.
If they used git instead, the repository would be tiny, and you could make a personal
copy of the entire wiki to take on the plane with you, then sync your changes back when you're done.</p> 
<p><cite><a href="http://www.advogato.org/person/apenwarr/diary/371.html">Git is the next Unix</a></cite></p>
</blockquote>


## Licence

git-wiki is avalaible on [GitHub][] as well as on `git://atonie.org/git-wiki.git`
under the [WTFPL][] license terms. That license basically
allows you to **do what the fuck you want with it**, without any restriction.


  [Sinatra]: http://sinatrarb.com
  [GitHub]: http://github.com/sr/git-wiki
  [forks]: http://github.com/sr/git-wiki/network
  [al3x]: http://github.com/al3x/github
  [WTFPL]: http://sam.zoy.org/wtfpl/