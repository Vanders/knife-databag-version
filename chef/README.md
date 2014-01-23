Versioned databags
==================

This directory contains the Chef runtime code which can be used to load a versioned databag item.

Usage
=====

Simply drop the `databags.rb` library into a convienient cookbook. You can then load versioned databag items by calling either the `get_current_item` or `get_versioned_item` methods.

Encrypted data bag items can be loaded with the similar `get_current_encrypted_item` and `get_versioned_encrypted_item` methods.

### get_current_item, get_current_encrypted_item

Retrieves a data bag item where the version matches the version of the Cookbook. This assumes that the data bag & Cookbook have the same name, I.e. a Cookbook named `myface` sources it's data bag items from a data bag named `myface`.

Use these methods when you simply need the databag item to match the current cookbook version.

#### Example

    databag = Dyn::Databags.get_current_item('myface', 'item')
    
### get_versioned_item, get_versioned_encrypted_item

Retrieves a data bag item of the given version. The version must be an absolute version number of the form `[Major].[Minor].[Patch]`.

#### Example

    databag = Dyn::Databags.get_versioned_item('myface', 'item', '1.3.3')
