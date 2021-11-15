class HomeController < ApplicationController
  before '/' do
    puts 'before2'
  end
  ['/', '/master-data/locations'].each do |path|
    get path do
      locals = {
        :title => 'Bienvenido',
        :href => '/',
        :csss => HomeHelper::index_css(settings.constants),
        :jss => HomeHelper::index_js(settings.constants),
      }
      erb :'home/index', :layout => :'layouts/blank', :locals => locals
    end  
  end
end