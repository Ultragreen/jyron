module JYRon
  module Helpers

    def readfile(filename)
      File::readlines(filename).join("\n")
    end
  end
end
