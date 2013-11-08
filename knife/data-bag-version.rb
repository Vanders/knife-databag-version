# encoding: utf-8
require 'databag-version'

module Dyn
  module Knife

    # Version all data bags items

    class DataBagVersion < Chef::Knife

      banner 'knife data bag version'

      def run
        DatabagVersion.process_all(false)
      end
    end

  end
end
