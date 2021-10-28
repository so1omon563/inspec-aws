# frozen_string_literal: true

require 'aws_backend'

class AWSSecurityHubHub < AwsResourceBase
  name 'aws_securityhub_hub'
  desc 'Gets information Security Hub.'

  example "
    describe aws_securityhub_hub(hub_arn: 'HUB_ARN') do
      it { should exist }
    end
  "

  def initialize(opts = {})
    opts = { hub_arn: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: [:hub_arn])
    raise ArgumentError, "#{@__resource_hub_arn__}: hub_arn must be provided" unless opts[:hub_arn] && !opts[:hub_arn].empty?
    @display_name = opts[:hub_arn]
    catch_aws_errors do
      resp = @aws.securityhub_client.describe_hub({ hub_arn: opts[:hub_arn] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def hub_arn
    return nil unless exists?
    @res[:hub_arn]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def to_s
    "HUB ARN: #{@display_name}"
  end
end
