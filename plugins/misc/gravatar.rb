description 'Display gravatar'

class Olelo::Application
  get '/_/user' do
    hash = md5(user.email.downcase)
    img = %{<img src="http://www.gravatar.com/avatar/#{hash}?d=identicon&amp;s=20" alt="Gravatar" style="float:left;margin:-2px 5px -2px 0"/>}
    (user.anonymous? ? img : %{<a href="/profile">#{img}</a>}) + super()
  end
end

