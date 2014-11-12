require 'chef/provisioning'
require 'chef/resource/aws_resource'

class Chef::Resource::AwsKeyPair < Chef::Resource::AwsResource
  self.resource_name = 'aws_key_pair'

  def initialize(*args)
    super
    @driver = run_context.chef_provisioning.current_driver
  end

  actions :create, :delete, :nothing
  default_action :create

  attribute :driver
  # Private key to use as input (will be generated if it does not exist)
  attribute :private_key_path, :kind_of => String
  # Public key to use as input (will be generated if it does not exist)
  attribute :public_key_path, :kind_of => String
  # List of parameters to the private_key resource used for generation of the key
  attribute :private_key_options, :kind_of => Hash

  # TODO what is the right default for this?
  attribute :allow_overwrite, :kind_of => [TrueClass, FalseClass], :default => false

  # Proc that runs after the resource completes.  Called with (resource, private_key, public_key)
  def after(&block)
    block ? @after = block : @after
  end
end
