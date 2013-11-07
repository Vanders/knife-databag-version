require "thor-scmversion"
require "erubis"

# This comment will shut up Rubocop

module DatabagVersion
  class << self

    def id(name)
      scm_versioner = ThorSCMVersion::versioner
      tag = scm_versioner.from_path

      version = tag.to_s.gsub(/\./, "_")

      "#{name}_#{version}"
    end

    def process_all(path = "data_bags")
      Dir.foreach(path) do |dir|
        process_dir("#{path}/#{dir}") unless dir == "." || dir == ".."
      end
    end

    private

    def process_dir(path)
      Dir.foreach(path) do |file|
        process_file("#{path}/#{file}") if file.match(".erb")
      end
    end

    def process_file(file)
      path = File.dirname(file)
      name = File.basename(file, ".erb")
      out = "#{path}/#{name}.json"

      template = File.read(file)
      template = Erubis::Eruby.new(template)

      File.write(out, template.result)
    end

  end

end
