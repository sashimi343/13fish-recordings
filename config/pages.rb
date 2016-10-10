page :index do
  title 'Index'
  path '/index.html'
  template 'index'
  resource 'news', 'news.yml'
  partial 'articles', 'articles/*', true
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
  heuschnupfen_ep: 'Heuschnupfen EP'
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
