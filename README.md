# Knife data bag version

While Chef understands the concept of versioned Cookbooks, other resources such as Roles & Data Bags are not versioned. This can cause problems mixing different versions of the same Cookbook within an organization if the data bags are shared between versions.

The knife data bag version plugin attempts to provide a mechanism to version data bag items to match the cookbook version. Coupled with a Chef runtime library, recipes can load a given version of the item which will match its requirements.

## Requirements

knife data bag version relies on thor-scmversion to manage the version information.

## Installation

  gem install knife-data-bag-version

## How does it work?

Instead of storing each data bag item as pure JSON, the items are stored as ERB templates. knife data bag version then processes each template with Erubis and produces a JSON data bag item with the version information injected.

For example, assume we have a simple data bag item:

  *my-data-bag-item.json*
  {
    "id": "my-data-bag-item",
    "users": ["kristian", "paul", "pete", "david", "bill"]
  }

For use with knife data bag version this becomes a template:

  *my-data-bag-item.erb*
  { "id": "<%= DatabagVersion.id('my-data-bag-item') %>",
    "users": ["kristian", "paul", "pete", "david", "bill"]
  }

knife data bag version can then create a JSON file using this template:

  knife data bag version
  Templating data bag item data\_bags/my-cookbook/my-data-bag-item

knife data bag version will emit a JSON file:

  *my-data-bag-item_1_2_0.json*
  {
    "id": "my-data-bag-item_1_2_0",
    "users": ["kristian", "paul", "pete", "david", "bill"]
  }

The three digits will naturally depend on the major, minor & patch versions of the current Cookbook. The version information is obtained from thor-scmversion, which means the data bag version will always match the cookbook. Each versioned data bag item is distinct from other versions, so you can safely have E.g. "my-data-bag-item\_1\_1\_3", "my-data-bag-item\_1\_2\_0" and "my-data-bag-item\_1\_2\_1" uploaded to the same organization.

## Limitations

The plugin relies on thor-scmversion, which means if you're not using it manage your cookbook versions knife data bag version will always version everything as version 0.0.1.

It assumes that all data bags are contained in a directory called "data\_bags", and it is assumed that the data bags are stored within the Cookbook itself. An example directory structure:

  my-cookbook
    metadata.rb
    Thorfile
    recipes
      default.rb
    libraries
      my-library.rb
    data_bags
      my-cookbook
        my-cookbook-item.erb

You would then run knife data bag version from the top of the tree, in the "my-cookbook" directory. If you run the knife data bag version and it can't find a directory called "data\_bags" it will fail silently.

How you load the data bags is currently an exercise for the reader, but I'll try to get a Chef runtime library into the Community Cookbooks repository soon.

This knife plugins is supplied without any warranty or guarantees regarding suitability for purpose.
