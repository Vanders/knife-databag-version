# encoding: utf-8
require 'databag-version'

module Dyn
  module Knife

    # Version all data bags items

    class DataBagVersion < Chef::Knife

      banner 'knife data bag version'

      option :quiet,
        :short => "-q",
        :long => "--quiet",
        :boolean => "false",
        :description => "Silence all informational output."

      def run
        DatabagVersion.process_all(config[:quiet])
      end
    end

  end
end
