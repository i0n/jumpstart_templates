module PROJECT_NAME
  class Base

    # Accessor methods to make testing input or output easier.
    attr_accessor :input, :output

    # Monkeypatch gets to make testing easier.
    def gets(*args)
      @input.gets(*args)
    end

    # Monkeypatch puts to make testing easier.
    def puts(*args)
      @output.puts(*args)
    end

    def initialize(args)
      # setup for testing input
      @input  = $stdin
      # setup for testing output
      @output = $stdout
    end


  end
end
