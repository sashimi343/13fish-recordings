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
