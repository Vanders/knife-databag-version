# encoding: utf-8
module Dyn

  module Databags

    # Try to return the version of the named cookbook.

    def self.get_cookbook_version(cookbook)
      cookbook_path = File.dirname(File.absolute_path(__FILE__))
      version_file = File.expand_path("#{cookbook_path}/../../#{cookbook}/VERSION")

      return unless File.exist?(version_file)

      File.read(version_file).strip
    end
    private_class_method :get_cookbook_version

    # The other way to do the above is to get the Cookbook version from the
    # metdata. Sadly the only way to get to that data from a Library like this
    # one is to have the caller pass the runtime "node" variable, where the
    # run_context can be extracted. In practice both versions return the
    # same data, and the one above is less ugly.
    #
    # def get_cookbook_version(node, data_bag)
    #   node.run_context.cookbook_collection[data_bag].metadata.version
    # end

    # Retrieve a data bag item of the given version.

    def self.get_versioned_item(data_bag, item, version)
      version.gsub!(/\./, '_')
      item_id = "#{item}_#{version}"

      Chef::DataBagItem.load(data_bag, item_id)
    end

    # Retrieve a data bag item where the version matches the version of the
    # Cookbook. This assumes that the data bag & Cookbook have the same name,
    # I.e. a Cookbook named "dyn_core" sources it's data bag items from a
    # data bag named "dyn_core".

    def self.get_current_item(data_bag, item)
      cookbook_version = get_cookbook_version(data_bag)
      get_versioned_item(data_bag, item, cookbook_version) unless cookbook_version.nil?
    end

    # Retrieve an encrypted data bag item of the given version.

    def self.get_versioned_encrypted_item(data_bag, item, version, secret = nil)
      version.gsub!(/\./, '_')
      item_id = "#{item}_#{version}"

      Chef::EncryptedDataBagItem.load(data_bag, item_id, secret)
    end

    # Retrieve an encrypted data bag item where the version matches the version
    # of the Cookbook. See get_current_data_bag_item above.

    def self.get_current_encrypted_item(data_bag, item, secret = nil)
      cookbook_version = get_cookbook_version(data_bag)
      get_versioned_encrypted_item(data_bag, item, cookbook_version, secret) unless cookbook_version.nil?
    end

  end

end
