module Home
  class Index < Ground::State

    def call
      @greet = "Hello Description"
      html static('app/index.html')
    end

  end
end
