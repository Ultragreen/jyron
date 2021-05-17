module JYRon
  module Helpers

    class HelpersError < Exception; end

    def readfile(filename)
      begin
        File::readlines(filename).join("\n")
      rescue Errno::ENOENT
        raise HelpersError.new "File #{filename} not found"
      end
    end
  end
end
