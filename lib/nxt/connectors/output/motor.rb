module NXT
  module Connector
    module Output
      class Motor
        attr_accessor :port

        def initialize(port)
          @port = port
        end
      end
    end
  end
end
