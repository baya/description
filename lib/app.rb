module Description
  App = Ground 'description' do
    use Rack::ShowExceptions
    use Rack::Static, urls: ['/assets']
  end
end
