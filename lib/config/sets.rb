Ground do
  set :logger, ::Logger.new(STDOUT)
  set :markdown, ::Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                           autolink: true,
                                           space_after_headers: true
                                           )
end
