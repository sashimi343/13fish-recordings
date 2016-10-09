page :index do
  title 'Index'
  path '/index.html'
  template 'index'
  resources news: 'news'
  partials articles: 'articles/*'
end

page :about do
  title 'About'
  path '/about.html'
  template 'about'
  parent :index
end
