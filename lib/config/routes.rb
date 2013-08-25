Ground do
  get '/', Home::Index
  get '/tables', Tables::Index
  get '/tables/:name', Tables::Show
end
