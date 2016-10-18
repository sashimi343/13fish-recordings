page :index do
  title 'Index'
  path '/index.html'
  template 'index'
  resource 'news', 'news.yml'
  partial 'articles', 'articles/*', true
  partial 'cross_fade', 'cross_fades/second_fish.slim'
end

page :about do
  title 'About'
  path '/about.html'
  template 'about'
  parent :index
end

page :works do
  title 'Works'
  path '/works/index.html'
  template 'works'
  resource 'albums', 'albums.yml'
  resource 'songs', 'songs.yml'
  parent :index
end

albums = {
  second_fish: 'Second FISH',
  fish_on_rice: 'FISH on RICE',
  athene: 'Athene Remix ALBUM',
  heuschnupfen_ep: 'Heuschnupfen EP',
  yoshio_ep: 'YOSHIO EP',
  first_fish: 'First FISH'
}

albums.each_pair do |id, title|
  page id do
    title title
    path "/works/#{id}/index.html"
    template 'work'
    resource 'album', "albums/#{id}.yml"
    partial 'description', "descriptions/#{id}.slim"
    partial 'cross_fade', "cross_fades/#{id}.slim"
    parent :works
  end
end

page :archive do
  title 'Archive'
  path '/archive/index.html'
  template 'archive'
  partial 'articles', 'articles/*', true
  parent :index
end

page :contact do
  title 'Contact'
  path '/contact.html'
  template 'contact'
  parent :index
end
