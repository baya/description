module Home
  class Index < Ground::State

    def call
      html plain('app/index.html')
    end

  end
end
