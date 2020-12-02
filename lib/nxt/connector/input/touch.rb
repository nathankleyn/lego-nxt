# frozen_string_literal: true

module NXT
  module Connector
    module Input
      # Implements the "touch" sensor for the NXT 2.0 module.
      class Touch
        def initialize(port)
          @port = port
        end
      end
    end
  end
end
