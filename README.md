# InSpec for AWS

* **Project State: Maintained**

For more information on project states and SLAs, see [this documentation](https://github.com/chef/chef-oss-practices/blob/master/repo-management/repo-states.md).

This InSpec resource pack uses the AWS Ruby SDK v3 and provides the required resources to write tests for resources in AWS.

## Prerequisites

### AWS Credentials

Valid AWS credentials are required, see [AWS Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal)

There are multiple ways to set the AWS credentials, as shown below:

#### 1) Environment Variables

Set your AWS credentials in a `.envrc` file or export them in your shell. (See example [.envrc file](.envrc_example))

```bash
    # Example configuration
    export AWS_ACCESS_KEY_ID="AKIAJUMP347SLS66IGCQ"
    export AWS_SECRET_ACCESS_KEY="vD2lfoNvPdwsofqyuO9jRuWUkZIMqisdfeFmkHTy7ON+w"
    export AWS_REGION="eu-west-3"
    export AWS_AVAILABILITY_ZONE="eu-west-3a"  
```

#### 2) Configuration File

Set your AWS credentials in `~/.aws/config` and `~/.aws/credentials` file. (See example [aws configure credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html))

Example `~/.aws/credentials` :

   ```bash
      [default]
      aws_access_key_id=AKIAIOSFODNN7EXAMPLE
      aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
      
      [engineering]
      aws_access_key_id=AKIAIOSFODNN7EXAMPLF
      aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY1
   ```

Example `~/.aws/config` :

 ```bash
    [default]
    region=us-west-2
    
    [engineering]
    region=us-east-2
 ```

 AWS SDK selects the default credentials unless `aws_profile` is set in an `.envrc`.

 ```bash
     # Example configuration
     export AWS_PROFILE="engineering"
 ```

##### The credentials precedence is

   1. Credentials set in `.envrc` OR as an Environment variable.
   2. Credentials set in `~/.aws/credentials` AND `~/.aws/config` AND `AWS_PROFILE` set as an Environment variable.
   3. Credentials set in `~/.aws/credentials` AND `~/.aws/config` AND `AWS_PROFILE` is NOT set as an Environment variable. Default credentials are used.

### AWS Region

The `aws_region` parameter queries resources in a specific region. If not provided, the AWS region set in environment variables or configuration files are used.

Example:

```ruby
describe aws_ec2_instances(aws_region: 'us-west-2') do
  its('count') { should eq 10 }
end
```

### Assuming an IAM role

Assuming an IAM role allows an IAM users gain additional (or different) permissions to perform actions in a different AWS account. (See example [aws configure IAM role](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html))

Example:

```bash
   [profile example_profile]
   role_arn = arn:aws:iam::123456789012:role/example_profile
   source_profile = user1
```

### Permissions

Each resource requires specific permissions to perform the operations required for testing. For example, to test an AWS EC2 instance, your service principal requires the `ec2:DescribeInstances` and `iam:GetInstanceProfile` permissions. You can find a comprehensive list of each resource's permissions needed in the [documentation](docs/).

## Use the Resources

Since this is an InSpec resource pack, it defines the InSpec resources and includes example tests only. To use the AWS resources in your tests, do the following:

```bash
inspec init profile --platform aws my-profile
```

The above command generates a sample inspec.yml that depends on `master`.  We recommend this is pinned to a release of the resource pack as follows:

```yaml
name: my-profile
title: My own AWS profile
version: 0.1.0
inspec_version: '>= 4.6.9'
depends:
  - name: inspec-aws
    url: https://github.com/inspec/inspec-aws/archive/x.tar.gz
supports:
  - platform: aws
```

### Use the Resources

Since this is an InSpec resource pack, it only defines InSpec resources. To use these resources in your controls, create your profile:

#### Create a profile

```bash
inspec init profile --platform aws my-profile
```

The above command generates a sample inspec.yml that depends on `master`.  We recommend this is pinned to a release of the resource pack as follows.

Example `inspec.yml`:

```yaml
name: my-profile
title: My own AWS profile
version: 0.1.0
inspec_version: '>= 4.6.9'
depends:
 - name: inspec-aws
   url: https://github.com/inspec/inspec-aws/archive/x.tar.gz
supports:
 - platform: aws
```

(For available inspec-aws versions, see this list of [inspec-aws versions](https://github.com/inspec/inspec-aws/releases).)

If a resource is in local, change the `url` to `path`.

```yaml
name: my-profile
title: My own AWS profile
version: 0.1.0
inspec_version: '>= 4.6.9'
depends:
 - name: inspec-aws
   path: ../my-profile
supports:
 - platform: aws
```

(For available inspec-aws versions, see this list of [inspec-aws versions](https://github.com/inspec/inspec-aws/releases).)

Add some tests and run the profile via:

```bash
inspec exec my-profile -t aws://
```

## Resource documentation

This resource pack allows the testing of the following AWS resources. If a resource you wish to test is not listed, please feel free to open an [Issue](https://github.com/inspec/inspec-aws/issues). As an open-source project, we also welcome public contributions via [Pull Request](https://github.com/inspec/inspec-aws/pulls).

InSpec AWS Supported Resources [https://docs.chef.io/inspec/resources/](https://docs.chef.io/inspec/resources/)

| Module Name | Services | Resource & Property Reference | Singular Resource | Plural Resource |
| --- | --- | --- | --- | --- |
| AmazonMQ | Application Integration | [AWS::AmazonMQ::Broker](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amazonmq-broker.html) | [aws_mq_broker](https://docs.chef.io/inspec/resources/aws_mq_broker/) | [aws_mq_brokers](https://docs.chef.io/inspec/resources/aws_mq_brokers/) |
|  |  | [AWS::AmazonMQ::Configuration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amazonmq-configuration.html) | [aws_mq_configuration](https://docs.chef.io/inspec/resources/aws_mq_configuration/) | [aws_mq_configurations](https://docs.chef.io/inspec/resources/aws_mq_configurations/) |
| Amplify Console | Front-end Web & Mobile | [AWS::Amplify::App](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amplify-app.html) | [aws_amplify_app](https://docs.chef.io/inspec/resources/aws_amplify_app/) | [aws_amplify_apps](https://docs.chef.io/inspec/resources/aws_amplify_apps/) |
|  |  | [AWS::Amplify::Branch](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amplify-branch.html) | [aws_amplify_branch](https://docs.chef.io/inspec/resources/aws_amplify_branch/) | [aws_amplify_branches](https://docs.chef.io/inspec/resources/aws_amplify_branches/) |
| API Gateway | Networking & Content Delivery | [AWS::ApiGateway::Account](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-account.html) | [aws_apigateway_account](https://docs.chef.io/inspec/resources/aws_apigateway_account/) | No Plural Resource |
|  |  | [AWS::ApiGateway::ApiKey](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-apikey.html) | [aws_apigateway_api_key](https://docs.chef.io/inspec/resources/aws_apigateway_api_key/) | [aws_apigateway_api_keys](https://docs.chef.io/inspec/resources/aws_apigateway_api_keys/) |
|  |  | [AWS::ApiGateway::Authorizer](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-authorizer.html) | [aws_apigateway_authorizer](https://docs.chef.io/inspec/resources/aws_apigateway_authorizer/) | [aws_apigateway_authorizers](https://docs.chef.io/inspec/resources/aws_apigateway_authorizers/) |
|  |  | [AWS::ApiGateway::BasePathMapping](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-basepathmapping.html) | [aws_apigateway_base_path_mapping](https://docs.chef.io/inspec/resources/aws_apigateway_base_path_mapping/) | [aws_apigateway_base_path_mappings](https://docs.chef.io/inspec/resources/aws_apigateway_base_path_mappings/) |
|  |  | [AWS::ApiGateway::ClientCertificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-clientcertificate.html) | [aws_apigateway_client_certificate](https://docs.chef.io/inspec/resources/aws_apigateway_client_certificate/) | [aws_apigateway_client_certificates](https://docs.chef.io/inspec/resources/aws_apigateway_client_certificates/) |
|  |  | [AWS::ApiGateway::Deployment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-deployment.html) | [aws_api_gateway_deployment](https://docs.chef.io/inspec/resources/aws_api_gateway_deployment/) | [aws_api_gateway_deployments](https://docs.chef.io/inspec/resources/aws_api_gateway_deployments/) |
|  |  | [AWS::ApiGateway::Method](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-method.html) | [aws_api_gateway_method](https://docs.chef.io/inspec/resources/aws_api_gateway_method/) | [aws_api_gateway_methods](https://docs.chef.io/inspec/resources/aws_api_gateway_methods/) |
|  |  | [AWS::ApiGateway::RestApi](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-restapi.html) | [aws_api_gateway_restapi](https://docs.chef.io/inspec/resources/aws_api_gateway_restapi/) | [aws_api_gateway_restapis](https://docs.chef.io/inspec/resources/aws_api_gateway_restapis/) |
|  |  | [AWS::ApiGateway::Stage](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-stage.html) | [aws_api_gateway_stage](https://docs.chef.io/inspec/resources/aws_api_gateway_stage/) | [aws_api_gateway_stages](https://docs.chef.io/inspec/resources/aws_api_gateway_stages/) |
|  |  | [AWS::ApiGateway::DocumentationPart](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-documentationpart.html) | [aws_api_gateway_documentation_part](https://docs.chef.io/inspec/resources/aws_api_gateway_documentation_part/) | [aws_api_gateway_documentation_parts](https://docs.chef.io/inspec/resources/aws_api_gateway_documentation_parts/) |
|  |  | [AWS::ApiGateway::DocumentationVersion](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-documentationversion.html) | [aws_api_gateway_documentation_version](https://docs.chef.io/inspec/resources/aws_api_gateway_documentation_version/) | [aws_api_gateway_documentation_versions](https://docs.chef.io/inspec/resources/aws_api_gateway_documentation_versions/) |
| Application Auto Scaling | Compute | [AWS::ApplicationAutoScaling::ScalableTarget](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-applicationautoscaling-scalabletarget.html) | [aws_application_autoscaling_scalable_target](https://docs.chef.io/inspec/resources/aws_application_autoscaling_scalable_target/) | [aws_application_autoscaling_scalable_targets](https://docs.chef.io/inspec/resources/aws_application_autoscaling_scalable_targets/) |
|  |  | [AWS::ApplicationAutoScaling::ScalingPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-applicationautoscaling-scalingpolicy.html) | [aws_application_autoscaling_scaling_policy](https://docs.chef.io/inspec/resources/aws_application_autoscaling_scaling_policy/) | [aws_application_autoscaling_scaling_policies](https://docs.chef.io/inspec/resources/aws_application_autoscaling_scaling_policies/) |
| Athena | Analytics | [AWS::Athena::WorkGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-athena-workgroup.html) | [aws_athena_work_group](https://docs.chef.io/inspec/resources/aws_athena_work_group/) | [aws_athena_work_groups](https://docs.chef.io/inspec/resources/aws_athena_work_groups/) |
| Amazon EC2 Auto Scaling | Compute | [AWS::AutoScaling::AutoScalingGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-as-group.html) | [aws_auto_scaling_group](https://docs.chef.io/inspec/resources/aws_auto_scaling_group/) | [aws_auto_scaling_groups](https://docs.chef.io/inspec/resources/aws_auto_scaling_groups/) |
|  |  | [AWS::AutoScaling::LaunchConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-as-launchconfig.html) | [aws_launch_configuration](https://docs.chef.io/inspec/resources/aws_launch_configuration/) | No Plural Resource |
|  |  | [AWS::AutoScaling::ScalingPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-as-policy.html) | [aws_autoscaling_scaling_policy](https://docs.chef.io/inspec/resources/aws_autoscaling_scaling_policy/) | [aws_autoscaling_scaling_policies](https://docs.chef.io/inspec/resources/aws_autoscaling_scaling_policies/) |
| AWS Batch | Compute | [AWS::Batch::ComputeEnvironment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-computeenvironment.html) | [aws_batch_compute_environment](https://docs.chef.io/inspec/resources/aws_batch_compute_environment/) | [aws_batch_compute_environments](https://docs.chef.io/inspec/resources/aws_batch_compute_environments/) |
|  |  | [AWS::Batch::JobDefinition](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-jobdefinition.html) | [aws_batch_job_definition](https://docs.chef.io/inspec/resources/aws_batch_job_definition/) | [aws_batch_job_definitions](https://docs.chef.io/inspec/resources/aws_batch_job_definitions/) |
|  |  | [AWS::Batch::JobQueue](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-jobqueue.html) | [aws_batch_job_queue](https://docs.chef.io/inspec/resources/aws_batch_job_queue/) | [aws_batch_job_queues](https://docs.chef.io/inspec/resources/aws_batch_job_queues/) |
| CloudFormation | Management & Governance | [AWS::CloudFormation::Stack](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-stack.html) | [aws_cloudformation_stack](https://docs.chef.io/inspec/resources/aws_cloudformation_stack/) | [aws_cloudformation_stacks](https://docs.chef.io/inspec/resources/aws_cloudformation_stacks/) |
|  |  | [AWS::CloudFormation::StackSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudformation-stackset.html) | [aws_cloud_formation_stack_set](https://docs.chef.io/inspec/resources/aws_cloud_formation_stack_set/) | [aws_cloud_formation_stack_sets](https://docs.chef.io/inspec/resources/aws_cloud_formation_stack_sets/) |
|  |  | Others | [aws_cloudformation_template](https://docs.chef.io/inspec/resources/aws_cloudformation_template/) | No Plural Resource |
| CloudFront | Networking & Content Delivery | [AWS::CloudFront::CachePolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-cachepolicy.html) | [aws_cloudfront_cache_policy](https://docs.chef.io/inspec/resources/aws_cloudfront_cache_policy/) | [aws_cloudfront_cache_policies](https://docs.chef.io/inspec/resources/aws_cloudfront_cache_policies/) |
|  |  | [AWS::CloudFront::CloudFrontOriginAccessIdentity](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-cloudfrontoriginaccessidentity.html) | [aws_cloudfront_origin_access_identity](https://docs.chef.io/inspec/resources/aws_cloudfront_origin_access_identity/) | [aws_cloudfront_origin_access_identities](https://docs.chef.io/inspec/resources/aws_cloudfront_origin_access_identities/) |
|  |  | [AWS::CloudFront::Distribution](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-distribution.html) | [aws_cloudfront_distribution](https://docs.chef.io/inspec/resources/aws_cloudfront_distribution/) | [aws_cloudfront_distributions](https://docs.chef.io/inspec/resources/aws_cloudfront_distributions/) |
|  |  | [AWS::CloudFront::KeyGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-keygroup.html) | [aws_cloudfront_key_group](https://docs.chef.io/inspec/resources/aws_cloudfront_key_group/) | [aws_cloudfront_key_groups](https://docs.chef.io/inspec/resources/aws_cloudfront_key_groups/) |
|  |  | [AWS::CloudFront::OriginRequestPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-originrequestpolicy.html) | [aws_cloud_front_origin_request_policy](https://docs.chef.io/inspec/resources/aws_cloud_front_origin_request_policy/) | No Plural Resource |
|  |  | [AWS::CloudFront::PublicKey](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-publickey.html) | [aws_cloudfront_public_key](https://docs.chef.io/inspec/resources/aws_cloudfront_public_key/) | [aws_cloudfront_public_keys](https://docs.chef.io/inspec/resources/aws_cloudfront_public_keys/) |
|  |  | [AWS::CloudFront::RealtimeLogConfig](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-realtimelogconfig.html) | [aws_cloudfront_realtime_log_config](https://docs.chef.io/inspec/resources/aws_cloudfront_realtime_log_config/) | [aws_cloudfront_realtime_log_configs](https://docs.chef.io/inspec/resources/aws_cloudfront_realtime_log_configs/) |
|  |  | [AWS::CloudFront::StreamingDistribution](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-streamingdistribution.html) | [aws_cloudfront_streaming_distribution](https://docs.chef.io/inspec/resources/aws_cloudfront_streaming_distribution/) | [aws_cloudfront_streaming_distributions](https://docs.chef.io/inspec/resources/aws_cloudfront_streaming_distributions/) |
| CloudTrail | Management & Governance | [AWS::CloudTrail::Trail](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudtrail-trail.html) | [aws_cloudtrail_trail](https://docs.chef.io/inspec/resources/aws_cloudtrail_trail/) | [aws_cloudtrail_trails](https://docs.chef.io/inspec/resources/aws_cloudtrail_trails/) |
| CloudWatch | Management & Governance | [AWS::CloudWatch::Alarm](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cw-alarm.html) | [aws_cloudwatch_alarm](https://docs.chef.io/inspec/resources/aws_cloudwatch_alarm/) | No Plural Resource |
|  |  | [AWS::CloudWatch::AnomalyDetector](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-anomalydetector.html) | [aws_cloudwatch_anomaly_detector](https://docs.chef.io/inspec/resources/aws_cloudwatch_anomaly_detector/) | [aws_cloudwatch_anomaly_detectors](https://docs.chef.io/inspec/resources/aws_cloudwatch_anomaly_detectors/) |
|  |  | [AWS::CloudWatch::CompositeAlarm](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-compositealarm.html) | [aws_cloudwatch_composite_alarm](https://docs.chef.io/inspec/resources/aws_cloudwatch_composite_alarm/) | [aws_cloudwatch_composite_alarms](https://docs.chef.io/inspec/resources/aws_cloudwatch_composite_alarms/) |
|  |  | [AWS::CloudWatch::Dashboard](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-dashboard.html) | [aws_cloudwatch_dashboard](https://docs.chef.io/inspec/resources/aws_cloudwatch_dashboard/) | [aws_cloudwatch_dashboards](https://docs.chef.io/inspec/resources/aws_cloudwatch_dashboards/) |
|  |  | [AWS::CloudWatch::InsightRule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-insightrule.html) | No Singular Resource | [aws_cloudwatch_insight_rules](https://docs.chef.io/inspec/resources/aws_cloudwatch_insight_rules/) |
|  |  | [AWS::CloudWatch::MetricStream](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-metricstream.html) | [aws_cloudwatch_metric_stream](https://docs.chef.io/inspec/resources/aws_cloudwatch_metric_stream/) | [aws_cloudwatch_metric_streams](https://docs.chef.io/inspec/resources/aws_cloudwatch_metric_streams/) |
| CloudWatch Logs | Management & Governance | [AWS::Logs::Destination](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-destination.html) | [aws_cloudwatchlogs_destination](https://docs.chef.io/inspec/resources/aws_cloudwatchlogs_destination/) | [aws_cloudwatchlogs_destinations](https://docs.chef.io/inspec/resources/aws_cloudwatchlogs_destinations/) |
|  |  | [AWS::Logs::LogGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-loggroup.html) | [aws_cloudwatch_log_group](https://docs.chef.io/inspec/resources/aws_cloudwatch_log_group/) | No Plural Resource |
|  |  | [AWS::Logs::LogStream](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-logstream.html) | [aws_cloudwatchlogs_log_stream](https://docs.chef.io/inspec/resources/aws_cloudwatchlogs_log_stream/) | [aws_cloudwatchlogs_log_streams](https://docs.chef.io/inspec/resources/aws_cloudwatchlogs_log_streams/) |
|  |  | [AWS::Logs::MetricFilter](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-metricfilter.html) | [aws_cloudwatch_log_metric_filter](https://docs.chef.io/inspec/resources/aws_cloudwatch_log_metric_filter/) | No Plural Resource |
|  |  |  | [aws_logs_metric_filter](https://docs.chef.io/inspec/resources/aws_logs_metric_filter/) | [aws_logs_metric_filters](https://docs.chef.io/inspec/resources/aws_logs_metric_filters/) |
|  |  | [AWS::Logs::SubscriptionFilter](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-subscriptionfilter.html) | [aws_cloudwatchlogs_subscription_filter](https://docs.chef.io/inspec/resources/aws_cloudwatchlogs_subscription_filter/) | [aws_cloudwatchlogs_subscription_filters](https://docs.chef.io/inspec/resources/aws_cloudwatchlogs_subscription_filters/) |
| Amazon Cognito | Security, Identity, & Compliance | [AWS::Cognito::IdentityPool](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-identitypool.html) | [aws_cognito_identity_pool](https://docs.chef.io/inspec/resources/aws_cognito_identity_pool/) | [aws_cognito_identity_pools](https://docs.chef.io/inspec/resources/aws_cognito_identity_pools/) |
|  |  | [AWS::Cognito::UserPool](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpool.html) | [aws_cognito_userpool](https://docs.chef.io/inspec/resources/aws_cognito_userpool/) | [aws_cognito_userpools](https://docs.chef.io/inspec/resources/aws_cognito_userpools/) |
|  |  | [AWS::Cognito::UserPoolClient](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpoolclient.html) | [aws_cognito_userpool_client](https://docs.chef.io/inspec/resources/aws_cognito_userpool_client/) | [aws_cognito_userpool_clients](https://docs.chef.io/inspec/resources/aws_cognito_userpool_clients/) |
| Config | Management & Governance  | [AWS::Config::ConfigurationRecorder](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-config-configurationrecorder.html) | [aws_config_recorder](https://docs.chef.io/inspec/resources/aws_config_recorder/) | No Plural Resource |
|  |   | [AWS::Config::DeliveryChannel](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-config-deliverychannel.html) | [aws_config_delivery_channel](https://docs.chef.io/inspec/resources/aws_config_delivery_channel/) | No Plural Resource |
| DMS | Compute | [AWS::DMS::Endpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-endpoint.html) | [aws_dms_endpoint](https://docs.chef.io/inspec/resources/aws_dms_endpoint/) | [aws_dms_endpoints](https://docs.chef.io/inspec/resources/aws_dms_endpoints/) |
|  |  | [AWS::DMS::ReplicationInstance](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-replicationinstance.html) | [aws_dms_replication_instance](https://docs.chef.io/inspec/resources/aws_dms_replication_instance/) | [aws_dms_replication_instances](https://docs.chef.io/inspec/resources/aws_dms_replication_instances/) |
|  |  | [AWS::DMS::ReplicationSubnetGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-replicationsubnetgroup.html) | [aws_dms_replication_subnet_group](https://docs.chef.io/inspec/resources/aws_dms_replication_subnet_group/) | [aws_dms_replication_subnet_groups](https://docs.chef.io/inspec/resources/aws_dms_replication_subnet_groups/) |
| DynamoDB | Database | [AWS::DynamoDB::Table](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dynamodb-table.html) | [aws_dynamodb_table](https://docs.chef.io/inspec/resources/aws_dynamodb_table/) | [aws_dynamodb_tables](https://docs.chef.io/inspec/resources/aws_dynamodb_tables/) |
| EC2 | Compute | [AWS::EC2::CapacityReservation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-capacityreservation.html) | [aws_ec2_capacity_reservation](https://docs.chef.io/inspec/resources/aws_ec2_capacity_reservation/) | [aws_ec2_capacity_reservations](https://docs.chef.io/inspec/resources/aws_ec2_capacity_reservations/) |
|  |  | [AWS::EC2::CarrierGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-carriergateway.html) | [aws_ec2_carrier_gateway](https://docs.chef.io/inspec/resources/aws_ec2_carrier_gateway/) | [aws_ec2_carrier_gateways](https://docs.chef.io/inspec/resources/aws_ec2_carrier_gateways/) |
|  |  | [AWS::EC2::CustomerGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-customer-gateway.html) | [aws_ec2_customer_gateway](https://docs.chef.io/inspec/resources/aws_ec2_customer_gateway/) | [aws_ec2_customer_gateways](https://docs.chef.io/inspec/resources/aws_ec2_customer_gateways/) |
|  |  | [AWS::EC2::DHCPOptions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-dhcpoptions.html) | No Singular Resource | [aws_dhcp_options](https://docs.chef.io/inspec/resources/aws_dhcp_options/) |
|  |  |  | [aws_ec2_dhcp_option](https://docs.chef.io/inspec/resources/aws_ec2_dhcp_option/) | [aws_ec2_dhcp_options](https://docs.chef.io/inspec/resources/aws_ec2_dhcp_options/) |
|  |  | [AWS::EC2::Fleet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-ec2fleet.html) | [aws_ec2_fleet](https://docs.chef.io/inspec/resources/aws_ec2_fleet/) | [aws_ec2_fleets](https://docs.chef.io/inspec/resources/aws_ec2_fleets/) |
|  |  | [AWS::EC2::EgressOnlyInternetGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-egressonlyinternetgateway.html) | [aws_ec2_egress_only_internet_gateway](https://docs.chef.io/inspec/resources/aws_ec2_egress_only_internet_gateway/) | [aws_ec2_egress_only_internet_gateways](https://docs.chef.io/inspec/resources/aws_ec2_egress_only_internet_gateways/) |
|  |  | [AWS::EC2::EIP](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-eip.html) | [aws_ec2_eip](https://docs.chef.io/inspec/resources/aws_ec2_eip/) | [aws_ec2_eips](https://docs.chef.io/inspec/resources/aws_ec2_eips/) |
|  |  | [AWS::EC2::EIPAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-eip-association.html) | [aws_ec2_eip_association](https://docs.chef.io/inspec/resources/aws_ec2_eip_association/) | [aws_ec2_eip_associations](https://docs.chef.io/inspec/resources/aws_ec2_eip_associations/) |
|  |  | [AWS::EC2::FlowLog](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-flowlog.html) | [aws_flow_log](https://docs.chef.io/inspec/resources/aws_flow_log/) | No Plural Resource |
|  |  | [AWS::EC2::Host](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-host.html) | [aws_ec2_host](https://docs.chef.io/inspec/resources/aws_ec2_host/) | [aws_ec2_hosts](https://docs.chef.io/inspec/resources/aws_ec2_hosts/) |
|  |  | [AWS::EC2::Instance](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-instance.html) | [aws_ec2_instance](https://docs.chef.io/inspec/resources/aws_ec2_instance/) | [aws_ec2_instances](https://docs.chef.io/inspec/resources/aws_ec2_instances/) |
|  |  | [AWS::EC2::InternetGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-internetgateway.html) | [aws_ec2_internet_gateway](https://docs.chef.io/inspec/resources/aws_ec2_internet_gateway/) | [aws_ec2_internet_gateways](https://docs.chef.io/inspec/resources/aws_ec2_internet_gateways/) |
|  |  |  | [aws_internet_gateway](https://docs.chef.io/inspec/resources/aws_internet_gateway/) | [aws_internet_gateways](https://docs.chef.io/inspec/resources/aws_internet_gateways/) |
|  |  | [AWS::EC2::LaunchTemplate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate.html) | [aws_ec2_launch_template](https://docs.chef.io/inspec/resources/aws_ec2_launch_template/) | [aws_ec2_launch_templates](https://docs.chef.io/inspec/resources/aws_ec2_launch_templates/) |
|  |  | [AWS::EC2::NatGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-natgateway.html) | [aws_nat_gateway](https://docs.chef.io/inspec/resources/aws_nat_gateway/) | [aws_nat_gateways](https://docs.chef.io/inspec/resources/aws_nat_gateways/) |
|  |  | [AWS::EC2::NetworkAcl](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-network-acl.html) | [aws_network_acl](https://docs.chef.io/inspec/resources/aws_network_acl/) | [aws_network_acls](https://docs.chef.io/inspec/resources/aws_network_acls/) |
|  |  | [AWS::EC2::NetworkAclEntry](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-network-acl-entry.html) | [aws_network_acl](https://docs.chef.io/inspec/resources/aws_network_acl/) | [aws_network_acls](https://docs.chef.io/inspec/resources/aws_network_acls/) |
|  |  | [AWS::EC2::NetworkInsightsAnalysis](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightsanalysis.html) | [aws_ec2_network_insights_analysis](https://docs.chef.io/inspec/resources/aws_ec2_network_insights_analysis/) | [aws_ec2_network_insights_analysis_plural](https://docs.chef.io/inspec/resources/aws_ec2_network_insights_analysis_plural/) |
|  |  | [AWS::EC2::NetworkInsightsPath](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightspath.html) | [aws_ec2_network_insights_path](https://docs.chef.io/inspec/resources/aws_ec2_network_insights_path/) | [aws_ec2_network_insights_paths](https://docs.chef.io/inspec/resources/aws_ec2_network_insights_paths/) |
|  |  | [AWS::EC2::NetworkInterface](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-network-interface.html) | [aws_ec2_network_interface](https://docs.chef.io/inspec/resources/aws_ec2_network_interface/) | [aws_ec2_network_interfaces](https://docs.chef.io/inspec/resources/aws_ec2_network_interfaces/) |
|  |  | [AWS::EC2::NetworkInterfaceAttachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-network-interface-attachment.html) | [aws_ec2_network_interface_attachment](https://docs.chef.io/inspec/resources/aws_ec2_network_interface_attachment/) | [aws_ec2_network_interface_attachments](https://docs.chef.io/inspec/resources/aws_ec2_network_interface_attachments/) |
|  |  | [AWS::EC2::NetworkInterfacePermission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinterfacepermission.html) | [aws_ec2_network_interface_permission](https://docs.chef.io/inspec/resources/aws_ec2_network_interface_permission/) | [aws_ec2_network_interface_permission](https://docs.chef.io/inspec/resources/aws_ec2_network_interface_permissions/) |
|  |  | [AWS::EC2::PlacementGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-placementgroup.html) | [aws_ec2_placement_group](https://docs.chef.io/inspec/resources/aws_ec2_placement_group/) | [aws_ec2_placement_groups](https://docs.chef.io/inspec/resources/aws_ec2_placement_groups/) |
|  |  | [AWS::EC2::PrefixList](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-prefixlist.html) | [aws_ec2_prefix_list](https://docs.chef.io/inspec/resources/aws_ec2_prefix_list/) | [aws_ec2_prefix_lists](https://docs.chef.io/inspec/resources/aws_ec2_prefix_lists/) |
|  |  | [AWS::EC2::Route](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-route.html) | [aws_route_table](https://docs.chef.io/inspec/resources/aws_route_table/) | [aws_route_tables](https://docs.chef.io/inspec/resources/aws_route_tables/) |
|  |  | [AWS::EC2::RouteTable](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-route-table.html) | [aws_route_table](https://docs.chef.io/inspec/resources/aws_route_table/) | [aws_route_tables](https://docs.chef.io/inspec/resources/aws_route_tables/) |
|  |  | [AWS::EC2::SecurityGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-security-group.html) | [aws_security_group](https://docs.chef.io/inspec/resources/aws_security_group/) | [aws_security_groups](https://docs.chef.io/inspec/resources/aws_security_groups/) |
|  |  | [AWS::EC2::SecurityGroupEgress](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-security-group-egress.html) | [aws_security_group](https://docs.chef.io/inspec/resources/aws_security_group/) | [aws_security_groups](https://docs.chef.io/inspec/resources/aws_security_groups/) |
|  |  | [AWS::EC2::SecurityGroupIngress](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-security-group-ingress.html) | [aws_security_group](https://docs.chef.io/inspec/resources/aws_security_group/) | [aws_security_groups](https://docs.chef.io/inspec/resources/aws_security_groups/) |
|  |  | [AWS::EC2::SpotFleet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-spotfleet.html) | [aws_ec2_spot_fleet](https://docs.chef.io/inspec/resources/aws_ec2_spot_fleet/) | [aws_ec2_spot_fleets](https://docs.chef.io/inspec/resources/aws_ec2_spot_fleets/) |
|  |  | [AWS::EC2::Subnet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-subnet.html) | [aws_subnet](https://docs.chef.io/inspec/resources/aws_subnet/) | [aws_subnets](https://docs.chef.io/inspec/resources/aws_subnets/) |
|  |  | [AWS::EC2::TrafficMirrorFilter](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-trafficmirrorfilter.html) | [aws_ec2_traffic_mirror_filter](https://docs.chef.io/inspec/resources/aws_ec2_traffic_mirror_filter/) | [aws_ec2_traffic_mirror_filters](https://docs.chef.io/inspec/resources/aws_ec2_traffic_mirror_filters/) |
|  |  | [AWS::EC2::TrafficMirrorSession](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-trafficmirrorsession.html) | [aws_ec2_traffic_mirror_session](https://docs.chef.io/inspec/resources/aws_ec2_traffic_mirror_session/) | [aws_ec2_traffic_mirror_sessions](https://docs.chef.io/inspec/resources/aws_ec2_traffic_mirror_sessions/) |
|  |  | [AWS::EC2::TrafficMirrorTarget](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-trafficmirrortarget.html) | [aws_ec2_traffic_mirror_target](https://docs.chef.io/inspec/resources/aws_ec2_traffic_mirror_target/) | [aws_ec2_traffic_mirror_targets](https://docs.chef.io/inspec/resources/aws_ec2_traffic_mirror_targets/) |
|  |  | [AWS::EC2::TransitGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgateway.html) | [aws_transit_gateway](https://docs.chef.io/inspec/resources/aws_transit_gateway/) | No Plural Resource |
|  |  | [AWS::EC2::TransitGatewayAttachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayattachment.html) | [aws_ec2_transit_gateway_attachment](https://docs.chef.io/inspec/resources/aws_ec2_transit_gateway_attachment/) | [aws_ec2_transit_gateway_attachments](https://docs.chef.io/inspec/resources/aws_ec2_transit_gateway_attachments/) |
|  |  | [AWS::EC2::TransitGatewayConnect](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayconnect.html) | [aws_transit_gateway_connect](https://docs.chef.io/inspec/resources/aws_transit_gateway_connect/) | [aws_transit_gateway_connects](https://docs.chef.io/inspec/resources/aws_transit_gateway_connects/) |
|  |  | [AWS::EC2::TransitGatewayMulticastDomain](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastdomain.html) | [aws_transit_gateway_multicast_domain](https://docs.chef.io/inspec/resources/aws_transit_gateway_multicast_domain/) | [aws_transit_gateway_multicast_domains](https://docs.chef.io/inspec/resources/aws_transit_gateway_multicast_domains/) |
|  |  | [AWS::EC2::TransitGatewayMulticastDomainAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastdomainassociation.html) | [aws_transit_gateway_multicast_domain_association](https://docs.chef.io/inspec/resources/aws_transit_gateway_multicast_domain_association/) | [aws_transit_gateway_multicast_domain_associations](https://docs.chef.io/inspec/resources/aws_transit_gateway_multicast_domain_associations/) |
|  |  | [AWS::EC2::TransitGatewayMulticastGroupMember](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastgroupmember.html) | [aws_transit_gateway_multicast_group_member](https://docs.chef.io/inspec/resources/aws_transit_gateway_multicast_group_member/) | [aws_transit_gateway_multicast_group_members](https://docs.chef.io/inspec/resources/aws_transit_gateway_multicast_group_members/) |
|  |  | [AWS::EC2::TransitGatewayMulticastGroupSource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastgroupsource.html) | [aws_transit_gateway_multicast_group_source](https://docs.chef.io/inspec/resources/aws_transit_gateway_multicast_group_source/) | [aws_transit_gateway_multicast_group_sources](https://docs.chef.io/inspec/resources/aws_transit_gateway_multicast_group_sources/) |
|  |  | [AWS::EC2::TransitGatewayRoute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroute.html) | [aws_transit_gateway_route](https://docs.chef.io/inspec/resources/aws_transit_gateway_route/) | [aws_transit_gateway_routes](https://docs.chef.io/inspec/resources/aws_transit_gateway_routes/) |
|  |  | [AWS::EC2::TransitGatewayRouteTable](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetable.html) | [aws_ec2_transit_gateway_route_table](https://docs.chef.io/inspec/resources/aws_ec2_transit_gateway_route_table/) | [aws_ec2_transit_gateway_route_tables](https://docs.chef.io/inspec/resources/aws_ec2_transit_gateway_route_tables/) |
|  |  | [AWS::EC2::TransitGatewayRouteTableAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetableassociation.html) | [aws_ec2_transit_gateway_route_table_association](https://docs.chef.io/inspec/resources/aws_ec2_transit_gateway_route_table_association/) | [aws_ec2_transit_gateway_route_table_associations](https://docs.chef.io/inspec/resources/aws_ec2_transit_gateway_route_table_associations/) |
|  |  | [AWS::EC2::TransitGatewayRouteTablePropagation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetablepropagation.html) | [aws_ec2_transit_gateway_route_table_propagation](https://docs.chef.io/inspec/resources/aws_ec2_transit_gateway_route_table_propagation/) | [aws_ec2_transit_gateway_route_table_propagations](https://docs.chef.io/inspec/resources/aws_ec2_transit_gateway_route_table_propagations/) |
|  |  | [AWS::EC2::Volume](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-ebs-volume.html) | [aws_ebs_volume](https://docs.chef.io/inspec/resources/aws_ebs_volume/) | [aws_ebs_volumes](https://docs.chef.io/inspec/resources/aws_ebs_volumes/) |
|  |  | [AWS::EC2::VolumeAttachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-ebs-volumeattachment.html) | No Singular Resource | [aws_ec2_volume_attachments](https://docs.chef.io/inspec/resources/aws_ec2_volume_attachments/) |
|  |  | [AWS::EC2::VPC](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpc.html) | [aws_vpc](https://docs.chef.io/inspec/resources/aws_vpc/) | [aws_vpcs](https://docs.chef.io/inspec/resources/aws_vpcs/) |
|  |  | [AWS::EC2::VPCEndpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcendpoint.html) | [aws_vpc_endpoint](https://docs.chef.io/inspec/resources/aws_vpc_endpoint/) | [aws_vpc_endpoints](https://docs.chef.io/inspec/resources/aws_vpc_endpoints/) |
|  |  | [AWS::EC2::VPCEndpointConnectionNotification](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcendpointconnectionnotification.html) | [aws_vpc_endpoint_connection_notification](https://docs.chef.io/inspec/resources/aws_vpc_endpoint_connection_notification/) | [aws_vpc_endpoint_connection_notifications](https://docs.chef.io/inspec/resources/aws_vpc_endpoint_connection_notifications/) |
|  |  |  | [aws_vpc_endpoint_notification](https://docs.chef.io/inspec/resources/aws_vpc_endpoint_notification/) | [aws_vpc_endpoint_notifications](https://docs.chef.io/inspec/resources/aws_vpc_endpoint_notifications/) |
|  |  | [AWS::EC2::VPCEndpointService](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcendpointservice.html) | [aws_vpc_endpoint_service](https://docs.chef.io/inspec/resources/aws_vpc_endpoint_service/) | [aws_vpc_endpoint_services](https://docs.chef.io/inspec/resources/aws_vpc_endpoint_services/) |
|  |  | [AWS::EC2::VPCEndpointServicePermissions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcendpointservicepermissions.html) | [aws_vpc_endpoint_service_permission](https://docs.chef.io/inspec/resources/aws_vpc_endpoint_service_permission/) | [aws_vpc_endpoint_service_permissions](https://docs.chef.io/inspec/resources/aws_vpc_endpoint_service_permissions/) |
|  |  | [AWS::EC2::VPCPeeringConnection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcpeeringconnection.html) | [aws_ec2_vpc_peering_connection](https://docs.chef.io/inspec/resources/aws_ec2_vpc_peering_connection/) | [aws_ec2_vpc_peering_connections](https://docs.chef.io/inspec/resources/aws_ec2_vpc_peering_connections/) |
|  |  | [AWS::EC2::VPNConnection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-connection.html) | No Singular Resource | [aws_vpn_connections](https://docs.chef.io/inspec/resources/aws_vpn_connections/) |
|  |  | [AWS::EC2::VPNConnectionRoute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-connection-route.html) | No Singular Resource | [aws_ec2_vpn_connection_routes](https://docs.chef.io/inspec/resources/aws_ec2_vpn_connection_routes/) |
|  |  | [AWS::EC2::VPNGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-gateway.html) | [aws_vpn_gateway](https://docs.chef.io/inspec/resources/aws_vpn_gateway/) | [aws_vpn_gateways](https://docs.chef.io/inspec/resources/aws_vpn_gateways/) |
|  |  | [AWS::EC2::VPNGatewayRoutePropagation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-gatewayrouteprop.html) | [aws_ec2_vpn_gateway_route_propagation](https://docs.chef.io/inspec/resources/aws_ec2_vpn_gateway_route_propagation/) | [aws_ec2_vpn_gateway_route_propagations](https://docs.chef.io/inspec/resources/aws_ec2_vpn_gateway_route_propagations/) |
|  |  | Others | [aws_region](https://docs.chef.io/inspec/resources/aws_region/) | [aws_regions](https://docs.chef.io/inspec/resources/aws_regions/) |
|  |  |  | [aws_ebs_snapshot](https://docs.chef.io/inspec/resources/aws_ebs_snapshot/) | [aws_ebs_snapshots](https://docs.chef.io/inspec/resources/aws_ebs_snapshots/) |
|  |  |  | [aws_ami](https://docs.chef.io/inspec/resources/aws_ami/) | [aws_amis](https://docs.chef.io/inspec/resources/aws_amis/) |
| Amazon ECR | Containers | [AWS::ECR::PublicRepository](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecr-publicrepository.html) | [aws_ecrpublic_repository](https://docs.chef.io/inspec/resources/aws_ecrpublic_repository/) | [aws_ecrpublic_repositories](https://docs.chef.io/inspec/resources/aws_ecrpublic_repositories/) | |
|  |  | [AWS::ECR::Repository](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecr-repository.html) | [aws_ecr_repository](https://docs.chef.io/inspec/resources/aws_ecr_repository/) | [aws_ecr_repositories](https://docs.chef.io/inspec/resources/aws_ecr_repositories/) |
| Amazon ECS | Containers | [AWS::ECS::Cluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-cluster.html) | [aws_ecs_cluster](https://docs.chef.io/inspec/resources/aws_ecs_cluster/) | [aws_ecs_clusters](https://docs.chef.io/inspec/resources/aws_ecs_clusters/) |
|  |  | [AWS::ECS::Service](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-service.html) | [aws_ecs_service](https://docs.chef.io/inspec/resources/aws_ecs_service/) | [aws_ecs_services](https://docs.chef.io/inspec/resources/aws_ecs_services/) |
|  |  | [AWS::ECS::TaskDefinition](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-taskdefinition.html) | [aws_ecs_task_definition](https://docs.chef.io/inspec/resources/aws_ecs_task_definition/) | [aws_ecs_task_definitions](https://docs.chef.io/inspec/resources/aws_ecs_task_definitions/) |
|  |  | Others | [aws_ecr_repository_policy](https://docs.chef.io/inspec/resources/aws_ecr_repository_policy/) | No Plural Resource |
|  |  |  | [aws_ecr](https://docs.chef.io/inspec/resources/aws_ecr/) | No Plural Resource |
|  |  |  | [aws_ecr_image](https://docs.chef.io/inspec/resources/aws_ecr_image/) | [aws_ecr_images](https://docs.chef.io/inspec/resources/aws_ecr_images/) |
| EFS | Storage | [AWS::EFS::FileSystem](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-efs-filesystem.html) | [aws_efs_file_system](https://docs.chef.io/inspec/resources/aws_efs_file_system/) | [aws_efs_file_systems](https://docs.chef.io/inspec/resources/aws_efs_file_systems/) |
|  |  | [AWS::EFS::MountTarget](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-efs-mounttarget.html) | [aws_efs_mount_target](https://docs.chef.io/inspec/resources/aws_efs_mount_target/) | [aws_efs_mount_targets](https://docs.chef.io/inspec/resources/aws_efs_mount_targets/) |
| EKS | Containers | [AWS::EKS::Cluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-eks-cluster.html) | [aws_eks_cluster](https://docs.chef.io/inspec/resources/aws_eks_cluster/) | [aws_eks_clusters](https://docs.chef.io/inspec/resources/aws_eks_clusters/)
| ElasticCache | Database | [AWS::ElastiCache::CacheCluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-elasticache-cache-cluster.html) | [aws_elasticache_cluster](https://docs.chef.io/inspec/resources/aws_elasticache_cluster/) | [aws_elasticache_clusters](https://docs.chef.io/inspec/resources/aws_elasticache_clusters/) |
|  |  | [AWS::ElastiCache::ReplicationGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticache-replicationgroup.html) | [aws_elasticache_replication_group](https://docs.chef.io/inspec/resources/aws_elasticache_replication_group/) | [aws_elasticache_replication_groups](https://docs.chef.io/inspec/resources/aws_elasticache_replication_groups/) |
|  |  |  | [aws_elasticache_cluster_node](https://docs.chef.io/inspec/resources/aws_elasticache_cluster_node/) | No Plural Resource |
| Elasticsearch | Analytics | [AWS::Elasticsearch::Domain](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticsearch-domain.html) | [aws_elasticsearchservice_domain](https://docs.chef.io/inspec/resources/aws_elasticsearchservice_domain/) | [aws_elasticsearchservice_domains](https://docs.chef.io/inspec/resources/aws_elasticsearchservice_domains/) |
| ElasticLoadBalancingV2 | Networking & Content Delivery | [AWS::ElasticLoadBalancingV2::Listener](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listener.html) | [aws_elasticloadbalancingv2_listener](https://docs.chef.io/inspec/resources/aws_elasticloadbalancingv2_listener/) | [aws_elasticloadbalancingv2_listeners](https://docs.chef.io/inspec/resources/aws_elasticloadbalancingv2_listeners/) |
|  |  | [AWS::ElasticLoadBalancingV2::ListenerCertificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenercertificate.html) | [aws_elasticloadbalancingv2_listener_certificate](https://docs.chef.io/inspec/resources/aws_elasticloadbalancingv2_listener_certificate/) | [aws_elasticloadbalancingv2_listener_certificates](https://docs.chef.io/inspec/resources/aws_elasticloadbalancingv2_listener_certificates/) |
|  |  | [AWS::ElasticLoadBalancingV2::ListenerRule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenerrule.html) | [aws_elasticloadbalancingv2_listener_rule](https://docs.chef.io/inspec/resources/aws_elasticloadbalancingv2_listener_rule/) | [aws_elasticloadbalancingv2_listener_rules](https://docs.chef.io/inspec/resources/aws_elasticloadbalancingv2_listener_rules/) |
|  |  | [AWS::ElasticLoadBalancingV2::LoadBalancer](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-loadbalancer.html) | [aws_elb](https://docs.chef.io/inspec/resources/aws_elb/) | [aws_elbs](https://docs.chef.io/inspec/resources/aws_elbs/) |
|  |  |  | [aws_alb](https://docs.chef.io/inspec/resources/aws_alb/) | [aws_albs](https://docs.chef.io/inspec/resources/aws_albs/) |
|  |  | [AWS::ElasticLoadBalancingV2::TargetGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-targetgroup.html) | [aws_elasticloadbalancingv2_target_group](https://docs.chef.io/inspec/resources/aws_elasticloadbalancingv2_target_group/) | [aws_elasticloadbalancingv2_target_groups](https://docs.chef.io/inspec/resources/aws_elasticloadbalancingv2_target_groups/) |
| Amazon EMR | Analytics  | [AWS::EMR::Cluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticmapreduce-cluster.html) | [aws_emr_cluster](https://docs.chef.io/inspec/resources/aws_emr_cluster/) | [aws_emr_clusters](https://docs.chef.io/inspec/resources/aws_emr_clusters/) |
|  |  | [AWS::EMR::SecurityConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-emr-securityconfiguration.html) | [aws_emr_security_configuration](https://docs.chef.io/inspec/resources/aws_emr_security_configuration/) | [aws_emr_security_configurations](https://docs.chef.io/inspec/resources/aws_emr_security_configurations/) |
| Amazon EventBridge | Application Integration  | [AWS::Events::Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-events-rule.html) | [aws_eventbridge_rule](https://docs.chef.io/inspec/resources/aws_eventbridge_rule/) | [aws_eventbridge_rules](https://docs.chef.io/inspec/resources/aws_eventbridge_rules/) |
| AWS Glue | Analytics | [AWS::Glue::Crawler](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-glue-crawler.html) | [aws_glue_crawler](https://docs.chef.io/inspec/resources/aws_glue_crawler/) | [aws_glue_crawlers](https://docs.chef.io/inspec/resources/aws_glue_crawlers/) |
|  |  | [AWS::Glue::Database](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-glue-database.html) | [aws_glue_database](https://docs.chef.io/inspec/resources/aws_glue_database/) | [aws_glue_databases](https://docs.chef.io/inspec/resources/aws_glue_databases/) |
| GuardDuty | Security, Identity, & Compliance | [AWS::GuardDuty::Detector](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-guardduty-detector.html) | [aws_guardduty_detector](https://docs.chef.io/inspec/resources/aws_guardduty_detector/) | [aws_guardduty_detectors](https://docs.chef.io/inspec/resources/aws_guardduty_detectors/) |
| IAM | Security, Identity, & Compliance | [AWS::IAM::AccessKey](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-accesskey.html) | [aws_iam_access_key](https://docs.chef.io/inspec/resources/aws_iam_access_key/) | [aws_iam_access_keys](https://docs.chef.io/inspec/resources/aws_iam_access_keys/) |
|  |  |  | No Singular Resource | [aws_iam_account_alias](https://docs.chef.io/inspec/resources/aws_iam_account_alias/) |
|  |  |  | [aws_iam_ssh_public_key](https://docs.chef.io/inspec/resources/aws_iam_ssh_public_key/) | [aws_iam_ssh_public_keys](https://docs.chef.io/inspec/resources/aws_iam_ssh_public_keys/) |
|  |  | [AWS::IAM::Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-group.html) | [aws_iam_group](https://docs.chef.io/inspec/resources/aws_iam_group/) | [aws_iam_groups](https://docs.chef.io/inspec/resources/aws_iam_groups/) |
|  |  | [AWS::IAM::InstanceProfile](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html) | [aws_iam_instance_profile](https://docs.chef.io/inspec/resources/aws_iam_instance_profile/) | [aws_iam_instance_profiles](https://docs.chef.io/inspec/resources/aws_iam_instance_profiles/) |
|  |  | [AWS::IAM::ManagedPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-managedpolicy.html) | [aws_iam_managed_policy](https://docs.chef.io/inspec/resources/aws_iam_managed_policy/) | [aws_iam_managed_policies](https://docs.chef.io/inspec/resources/aws_iam_managed_policies/) |
|  |  | [AWS::IAM::OIDCProvider](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-oidcprovider.html) | [aws_iam_oidc_provider](https://docs.chef.io/inspec/resources/aws_iam_oidc_provider/) | [aws_iam_oidc_providers](https://docs.chef.io/inspec/resources/aws_iam_oidc_providers/) |
|  |  | [AWS::IAM::Policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-policy.html) | [aws_iam_policy](https://docs.chef.io/inspec/resources/aws_iam_policy/) | [aws_iam_policies](https://docs.chef.io/inspec/resources/aws_iam_policies/) |
|  |  |  | [aws_iam_password_policy](https://docs.chef.io/inspec/resources/aws_iam_password_policy/) | No Plural Resource |
|  |  |  | [aws_iam_inline_policy](https://docs.chef.io/inspec/resources/aws_iam_inline_policy/) | No Plural Resource |
|  |  | [AWS::IAM::Role](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role.html) | [aws_iam_role](https://docs.chef.io/inspec/resources/aws_iam_role/) | [aws_iam_roles](https://docs.chef.io/inspec/resources/aws_iam_roles/) |
|  |  | [AWS::IAM::SAMLProvider](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-samlprovider.html) | [aws_iam_saml_provider](https://docs.chef.io/inspec/resources/aws_iam_saml_provider/) | [aws_iam_saml_providers](https://docs.chef.io/inspec/resources/aws_iam_saml_providers/) |
|  |  | [AWS::IAM::ServerCertificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-servercertificate.html) | [aws_iam_server_certificate](https://docs.chef.io/inspec/resources/aws_iam_server_certificate/) | [aws_iam_server_certificates](https://docs.chef.io/inspec/resources/aws_iam_server_certificates/) |
|  |  | [AWS::IAM::ServiceLinkedRole](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-servicelinkedrole.html) | [aws_iam_service_linked_role_deletion_status](https://docs.chef.io/inspec/resources/aws_iam_service_linked_role_deletion_status/) | No Plural Resource |
|  |  | [AWS::IAM::User](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-user.html) | [aws_iam_user](https://docs.chef.io/inspec/resources/aws_iam_user/) | [aws_iam_users](https://docs.chef.io/inspec/resources/aws_iam_users/) |
|  |  |  | [aws_iam_root_user](https://docs.chef.io/inspec/resources/aws_iam_root_user/) | No Plural Resource |
|  |  | [AWS::IAM::VirtualMFADevice](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-virtualmfadevice.html) | No Singular Resource | [aws_iam_virtual_mfa_devices](https://docs.chef.io/inspec/resources/aws_iam_virtual_mfa_devices/) |
|  |  | Others | [aws_iam_ssh_public_key](https://docs.chef.io/inspec/resources/aws_iam_ssh_public_key/) | [aws_iam_ssh_public_keys](https://docs.chef.io/inspec/resources/aws_iam_ssh_public_keys/) |
| KMS | Security, Identity, & Compliance | [AWS::KMS::Key](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-kms-key.html) | [aws_kms_key](https://docs.chef.io/inspec/resources/aws_kms_key/) | [aws_kms_keys](https://docs.chef.io/inspec/resources/aws_kms_keys/) |
| Lambda | Compute | [AWS::Lambda::Alias](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-alias.html) | [aws_lambda_alias](https://docs.chef.io/inspec/resources/aws_lambda_alias/) | [aws_lambda_aliases](https://docs.chef.io/inspec/resources/aws_lambda_aliases/) |
|  |  | [AWS::Lambda::CodeSigningConfig](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-codesigningconfig.html) | [aws_lambda_code_signing_config](https://docs.chef.io/inspec/resources/aws_lambda_code_signing_config/) | [aws_lambda_code_signing_configs](https://docs.chef.io/inspec/resources/aws_lambda_code_signing_configs/) |
|  |  | [AWS::Lambda::EventInvokeConfig](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-eventinvokeconfig.html) | [aws_lambda_event_invoke_config](https://docs.chef.io/inspec/resources/aws_lambda_event_invoke_config/) | [aws_lambda_event_invoke_configs](https://docs.chef.io/inspec/resources/aws_lambda_event_invoke_configs/) |
|  |  | [AWS::Lambda::EventSourceMapping](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-eventsourcemapping.html) | [aws_lambda_event_source_mapping](https://docs.chef.io/inspec/resources/aws_lambda_event_source_mapping/) | [aws_lambda_event_source_mappings](https://docs.chef.io/inspec/resources/aws_lambda_event_source_mappings/) |
|  |  | [AWS::Lambda::Function](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-function.html) | [aws_lambda](https://docs.chef.io/inspec/resources/aws_lambda/) | [aws_lambdas](https://docs.chef.io/inspec/resources/aws_lambdas/) |
|  |  | [AWS::Lambda::LayerVersionPermission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-layerversionpermission.html) | [aws_lambda_layer_version_permission](https://docs.chef.io/inspec/resources/aws_lambda_layer_version_permission/) | No Plural Resource |
|  |  | [AWS::Lambda::Permission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-permission.html) | [aws_lambda_permission](https://docs.chef.io/inspec/resources/aws_lambda_permission/) | [aws_lambda_permissions](https://docs.chef.io/inspec/resources/aws_lambda_permissions/) |
|  |  | [AWS::Lambda::Version](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-version.html) | [aws_lambda_version](https://docs.chef.io/inspec/resources/aws_lambda_version/) | [aws_lambda_versions](https://docs.chef.io/inspec/resources/aws_lambda_versions/) |
| Network Firewall | Security, Identity, & Compliance | [AWS::NetworkFirewall::Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html) | [aws_network_firewall_firewall](https://docs.chef.io/inspec/resources/aws_network_firewall_firewall/) | [aws_network_firewall_firewalls](https://docs.chef.io/inspec/resources/aws_network_firewall_firewalls/) |
|  |  | [AWS::NetworkFirewall::FirewallPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewallpolicy.html) | [aws_network_firewall_firewall_policy](https://docs.chef.io/inspec/resources/aws_network_firewall_firewall_policy/) | [aws_network_firewall_firewall_policies](https://docs.chef.io/inspec/resources/aws_network_firewall_firewall_policies/) |
|  |  | [AWS::NetworkFirewall::LoggingConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-loggingconfiguration.html) | [aws_network_firewall_logging_configuration](https://docs.chef.io/inspec/resources/aws_network_firewall_logging_configuration/) | No Plural Resource |
|  |  | [AWS::NetworkFirewall::RuleGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-rulegroup.html) | [aws_network_firewall_rule_group](https://docs.chef.io/inspec/resources/aws_network_firewall_rule_group/) | [aws_network_firewall_rule_groups](https://docs.chef.io/inspec/resources/aws_network_firewall_rule_groups/) |
| NetworkManager | Networking & Content Delivery | [AWS::NetworkManager::CustomerGatewayAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-customergatewayassociation.html) | [aws_network_manager_customer_gateway_association](https://docs.chef.io/inspec/resources/aws_network_manager_customer_gateway_association/) | [aws_network_manager_customer_gateway_associations](https://docs.chef.io/inspec/resources/aws_network_manager_customer_gateway_associations/) |
|  |  | [AWS::NetworkManager::Device](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-device.html) | [aws_network_manager_device](https://docs.chef.io/inspec/resources/aws_network_manager_device/) | [aws_network_manager_devices](https://docs.chef.io/inspec/resources/aws_network_manager_devices/) |
|  |  | [AWS::NetworkManager::GlobalNetwork](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-globalnetwork.html) | [aws_network_manager_global_network](https://docs.chef.io/inspec/resources/aws_network_manager_global_network/) | [aws_network_manager_global_networks](https://docs.chef.io/inspec/resources/aws_network_manager_global_networks/) |
| Organizations | Management & Governance | AWS::Organizations::Member | [aws_organizations_member](https://docs.chef.io/inspec/resources/aws_organizations_member/) | No Plural Resource |
| RAM | Security, Identity, & Compliance | [AWS::RAM::ResourceShare](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ram-resourceshare.html) | [aws_ram_resource_share](https://docs.chef.io/inspec/resources/aws_ram_resource_share/) | [aws_ram_resource_shares](https://docs.chef.io/inspec/resources/aws_ram_resource_shares/) |
| RDS | Database | [AWS::RDS::DBCluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbcluster.html) | [aws_rds_cluster](https://docs.chef.io/inspec/resources/aws_rds_cluster/) | [aws_rds_clusters](https://docs.chef.io/inspec/resources/aws_rds_clusters/) |
|  |  |  | [aws_rds_db_cluster_snapshot](https://docs.chef.io/inspec/resources/aws_rds_db_cluster_snapshot/) | [aws_rds_db_cluster_snapshots](https://docs.chef.io/inspec/resources/aws_rds_db_cluster_snapshots/)
|  |  | [AWS::RDS::DBInstance](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-database-instance.html) | [aws_rds_instance](https://docs.chef.io/inspec/resources/aws_rds_instance/) | [aws_rds_instances](https://docs.chef.io/inspec/resources/aws_rds_instances/)
|  |  | [AWS::RDS::DBParameterGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-dbparametergroup.html) | [aws_db_parameter_group](https://docs.chef.io/inspec/resources/aws_db_parameter_group/) | [aws_db_parameter_groups](https://docs.chef.io/inspec/resources/aws_db_parameter_groups/) |
|  |  | [AWS::RDS::DBProxy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbproxy.html) | [aws_rds_db_proxy](https://docs.chef.io/inspec/resources/aws_rds_db_proxy/) | No Plural Resource |
|  |  | [AWS::RDS::DBProxyEndpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbproxyendpoint.html) | [aws_rds_db_proxy_endpoint](https://docs.chef.io/inspec/resources/aws_rds_db_proxy_endpoint/) | [aws_rds_db_proxy_endpoints](https://docs.chef.io/inspec/resources/aws_rds_db_proxy_endpoints/) |
|  |  | [AWS::RDS::DBProxyTargetGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbproxytargetgroup.html) | [aws_rds_db_proxy_target_group](https://docs.chef.io/inspec/resources/aws_rds_db_proxy_target_group/) | [aws_rds_db_proxy_target_groups](https://docs.chef.io/inspec/resources/aws_rds_db_proxy_target_groups/) |
|  |  | [AWS::RDS::DBSecurityGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-security-group.html) | [aws_rds_db_security_group](https://docs.chef.io/inspec/resources/aws_rds_db_security_group/) | [aws_rds_db_security_groups](https://docs.chef.io/inspec/resources/aws_rds_db_security_groups/) |
|  |  | [AWS::RDS::DBSubnetGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbsubnet-group.html) | [aws_db_subnet_group](https://docs.chef.io/inspec/resources/aws_db_subnet_group/) | [aws_db_subnet_groups](https://docs.chef.io/inspec/resources/aws_db_subnet_groups/) |
|  |  | [AWS::RDS::EventSubscription](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-eventsubscription.html) | [aws_rds_event_subscription](https://docs.chef.io/inspec/resources/aws_rds_event_subscription/) | [aws_rds_event_subscriptions](https://docs.chef.io/inspec/resources/aws_rds_event_subscriptions/) |
|  |  | [AWS::RDS::GlobalCluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-globalcluster.html) | [aws_rds_global_cluster](https://docs.chef.io/inspec/resources/aws_rds_global_cluster/) | [aws_rds_global_clusters](https://docs.chef.io/inspec/resources/aws_rds_global_clusters/) |
|  |  | [AWS::RDS::OptionGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-optiongroup.html) | [aws_rds_group_option](https://docs.chef.io/inspec/resources/aws_rds_group_option/) | [aws_rds_group_options](https://docs.chef.io/inspec/resources/aws_rds_group_options/) |
|  |  | Others | [aws_rds_snapshot](https://docs.chef.io/inspec/resources/aws_rds_snapshot/) | [aws_rds_snapshots](https://docs.chef.io/inspec/resources/aws_rds_snapshots/) |
|  |  |  | No Singular Resource | [aws_rds_snapshot_attributes](https://docs.chef.io/inspec/resources/aws_rds_snapshot_attributes/) |
| Amazon Redshift | Analytics | [AWS::Redshift::Cluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-cluster.html) | [aws_redshift_cluster](https://docs.chef.io/inspec/resources/aws_redshift_cluster/) | [aws_redshift_clusters](https://docs.chef.io/inspec/resources/aws_redshift_clusters/) |
|  |  | [AWS::Redshift::ClusterParameterGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-clusterparametergroup.html) | [aws_redshift_cluster_parameter_group](https://docs.chef.io/inspec/resources/aws_redshift_cluster_parameter_group/) | [aws_redshift_cluster_parameter_groups](https://docs.chef.io/inspec/resources/aws_redshift_cluster_parameter_groups/) |
| Route 53 | Networking & Content Delivery | [AWS::Route53::HostedZone](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53-hostedzone.html) | [aws_hosted_zone](https://docs.chef.io/inspec/resources/aws_hosted_zone/) | [aws_hosted_zones](https://docs.chef.io/inspec/resources/aws_hosted_zones/) |
|  |  | [AWS::Route53::RecordSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-route53-recordset.html) | [aws_route53_record_set](https://docs.chef.io/inspec/resources/aws_route53_record_set/) | [aws_route53_record_sets](https://docs.chef.io/inspec/resources/aws_route53_record_sets/) |
| Route 53 Resolver | Networking & Content Delivery  | [AWS::Route53Resolver::ResolverEndpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53resolver-resolverendpoint.html) | [aws_route53resolver_resolver_endpoint](https://docs.chef.io/inspec/resources/aws_route53resolver_resolver_endpoint/) | [aws_route53resolver_resolver_endpoints](https://docs.chef.io/inspec/resources/aws_route53resolver_resolver_endpoints/) |
|  |  | [AWS::Route53Resolver::ResolverRule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53resolver-resolverrule.html) | [aws_route53resolver_resolver_rule](https://docs.chef.io/inspec/resources/aws_route53resolver_resolver_rule/) | [aws_route53resolver_resolver_rules](https://docs.chef.io/inspec/resources/aws_route53resolver_resolver_rules/) |
|  |  | [AWS::Route53Resolver::ResolverRuleAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53resolver-resolverruleassociation.html) | [aws_route53resolver_resolver_rule_association](https://docs.chef.io/inspec/resources/aws_route53resolver_resolver_rule_association/) | [aws_route53resolver_resolver_rule_associations](https://docs.chef.io/inspec/resources/aws_route53resolver_resolver_rule_associations/) |
| Amazon S3 | Compute | [AWS::S3::AccessPoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-accesspoint.html) | [aws_s3_access_point](https://docs.chef.io/inspec/resources/aws_s3_access_point/) | [aws_s3_access_points](https://docs.chef.io/inspec/resources/aws_s3_access_points/) |
|  |  | [AWS::S3::Bucket](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket.html) | [aws_s3_bucket](https://docs.chef.io/inspec/resources/aws_s3_bucket/) | [aws_s3_buckets](https://docs.chef.io/inspec/resources/aws_s3_buckets/) |
|  |  | [AWS::S3::BucketPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-policy.html) | [aws_s3_bucket_policy](https://docs.chef.io/inspec/resources/aws_s3_bucket_policy/) | No Plural Resource |
|  |  | Others | [aws_s3_bucket_object](https://docs.chef.io/inspec/resources/aws_s3_bucket_object/) | [aws_s3_bucket_objects](https://docs.chef.io/inspec/resources/aws_s3_bucket_objects/) |
| Secrets Manager | Security, Identity, & Compliance | [AWS::SecretsManager::Secret](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-secretsmanager-secret.html) | [aws_secretsmanager_secret](https://docs.chef.io/inspec/resources/aws_secretsmanager_secret/) | [aws_secretsmanager_secrets](https://docs.chef.io/inspec/resources/aws_secretsmanager_secrets/) |
| Service Catalog | Management & Governance | [AWS::ServiceCatalog::CloudFormationProduct](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-cloudformationproduct.html) | [aws_servicecatalog_cloud_formation_product](https://docs.chef.io/inspec/resources/aws_servicecatalog_cloud_formation_product/) | No Plural Resource |
|  |  | [AWS::ServiceCatalog::LaunchRoleConstraint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-launchroleconstraint.html) | [aws_servicecatalog_launch_role_constraint](https://docs.chef.io/inspec/resources/aws_servicecatalog_launch_role_constraint/) | [aws_servicecatalog_launch_role_constraints](https://docs.chef.io/inspec/resources/aws_servicecatalog_launch_role_constraints/) |
|  |  | [AWS::ServiceCatalog::PortfolioPrincipalAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-portfolioprincipalassociation.html) | [aws_servicecatalog_portfolio_principal_association](https://docs.chef.io/inspec/resources/aws_servicecatalog_portfolio_principal_association/) | [aws_servicecatalog_portfolio_principal_associations](https://docs.chef.io/inspec/resources/aws_servicecatalog_portfolio_principal_associations/) |
|  |  | [AWS::ServiceCatalog::PortfolioProductAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-portfolioproductassociation.html) | [aws_servicecatalog_portfolio_product_association](https://docs.chef.io/inspec/resources/aws_servicecatalog_portfolio_product_association/) |  [aws_servicecatalog_portfolio_product_associations](https://docs.chef.io/inspec/resources/aws_servicecatalog_portfolio_product_associations/) |
| Shield | Security, Identity, & Compliance | [AWS::Shield::Subscription]() | [aws_shield_subscription](https://docs.chef.io/inspec/resources/aws_shield_subscription/) | No Plural Resource |
| SecurityHub | Security, Identity, & Compliance | [AWS::SecurityHub::Hub](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-securityhub-hub.html) | [aws_securityhub_hub](https://docs.chef.io/inspec/resources/aws_securityhub_hub/) | No Plural Resource |
| Amazon SES | Business Applications | [AWS::SES::ReceiptRule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ses-receiptrule.html) | [aws_ses_receipt_rule](https://docs.chef.io/inspec/resources/aws_ses_receipt_rule/) | No Plural Resource |
|  |  | [AWS::SES::ReceiptRuleSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ses-receiptruleset.html) | [aws_ses_receipt_rule_set](https://docs.chef.io/inspec/resources/aws_ses_receipt_rule_set/) | [aws_ses_receipt_rule_sets](https://docs.chef.io/inspec/resources/aws_ses_receipt_rule_sets/) |
|  |  | [AWS::SES::Template](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ses-template.html) | [aws_ses_template](https://docs.chef.io/inspec/resources/aws_ses_template/) | [aws_ses_templates](https://docs.chef.io/inspec/resources/aws_ses_templates/) |
| Amazon SimpleDB | Simple Database Service | [AWS::SDB::Domain](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-simpledb.html) | No Singular Resource | [aws_sdb_domains](https://docs.chef.io/inspec/resources/aws_sdb_domains/) |
| Signer | Security, Identity, & Compliance | [AWS::Signer::ProfilePermission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-signer-profilepermission.html) | No Singular Resource | [aws_signer_profile_permissions](https://docs.chef.io/inspec/resources/aws_signer_profile_permissions/) |
|  |  | [AWS::Signer::SigningProfile](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-signer-signingprofile.html) | [aws_signer_signing_profile](https://docs.chef.io/inspec/resources/aws_signer_signing_profile/) | [aws_signer_signing_profiles](https://docs.chef.io/inspec/resources/aws_signer_signing_profiles/) |
| Amazon SNS | Application Integration | [AWS::SNS::Subscription](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-sns-subscription.html) | [aws_sns_subscription](https://docs.chef.io/inspec/resources/aws_sns_subscription/) | [aws_sns_subscriptions](https://docs.chef.io/inspec/resources/aws_sns_subscriptions/) |
|  |  | [AWS::SNS::Topic](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-sns-topic.html) | [aws_sns_topic](https://docs.chef.io/inspec/resources/aws_sns_topic/) |  [aws_sns_topics](https://docs.chef.io/inspec/resources/aws_sns_topics/) |
|  |  | [AWS::SNS::TopicPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-sns-policy.html) | [aws_sns_topic](https://docs.chef.io/inspec/resources/aws_sns_topic/) |  [aws_sns_topics](https://docs.chef.io/inspec/resources/aws_sns_topics/) |
| Amazon SQS | Application Integration | [AWS::SQS::Queue](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-sqs-queues.html) | [aws_sqs_queue](https://docs.chef.io/inspec/resources/aws_sqs_queue/) |  [aws_sqs_queues](https://docs.chef.io/inspec/resources/aws_sqs_queues/) |
|  |  | [AWS::SQS::QueuePolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-sqs-policy.html) | [aws_sqs_queue](https://docs.chef.io/inspec/resources/aws_sqs_queue/) |  [aws_sqs_queues](https://docs.chef.io/inspec/resources/aws_sqs_queues/) |
| SSO | Security, Identity, & Compliance | [AWS::SSO::Assignment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-sso-assignment.html) | [aws_sso_assignment](https://docs.chef.io/inspec/resources/aws_sso_assignment/) | [aws_sso_assignments](https://docs.chef.io/inspec/resources/aws_sso_assignments/) |
|  |  | [AWS::SSO::InstanceAccessControlAttributeConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-sso-instanceaccesscontrolattributeconfiguration.html) | [aws_sso_instance_access_control_attribute_configuration](https://docs.chef.io/inspec/resources/aws_sso_instance_access_control_attribute_configuration/) | [aws_sso_instance_access_control_attribute_configurations](https://docs.chef.io/inspec/resources/aws_sso_instance_access_control_attribute_configurations/) |
|  |  | [AWS::SSO::PermissionSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-sso-permissionset.html) | [aws_sso_permission_set](https://docs.chef.io/inspec/resources/aws_sso_permission_set/) | [aws_sso_permission_sets](https://docs.chef.io/inspec/resources/aws_sso_permission_sets/) |
| Step Functions | Application Integration | [AWS::StepFunctions::Activity](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-stepfunctions-activity.html) | [aws_stepfunctions_activity](https://docs.chef.io/inspec/resources/aws_stepfunctions_activity/) |  [aws_stepfunctions_activities](https://docs.chef.io/inspec/resources/aws_stepfunctions_activities/) |
|  |  | [AWS::StepFunctions::StateMachine](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-stepfunctions-statemachine.html) | [aws_stepfunctions_state_machine](https://docs.chef.io/inspec/resources/aws_stepfunctions_state_machine/) |  [aws_stepfunctions_state_machines](https://docs.chef.io/inspec/resources/aws_stepfunctions_state_machines/) |
| STS | Security, Identity, & Compliance | AWS::STS::CallerIdentity | [aws_sts_caller_identity](https://docs.chef.io/inspec/resources/aws_sts_caller_identity/) | No Plural Resource |
| CloudWatch Synthetics | Synthetics | [AWS::Synthetics::Canary](Amazon) | [aws_synthetics_canary](https://docs.chef.io/inspec/resources/aws_synthetics_canary/) | [aws_synthetics_canaries](https://docs.chef.io/inspec/resources/aws_synthetics_canaries/) |
| System Manager | Management & Governance | [AWS::SSM::Association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-association.html) | [aws_ssm_association](https://docs.chef.io/inspec/resources/aws_ssm_association/) | [aws_ssm_associations](https://docs.chef.io/inspec/resources/aws_ssm_associations/) |
|  |  | [AWS::SSM::Document](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-document.html) | [aws_ssm_document](https://docs.chef.io/inspec/resources/aws_ssm_document/) | [aws_ssm_documents](https://docs.chef.io/inspec/resources/aws_ssm_documents/) |
|  |  | [AWS::SSM::MaintenanceWindow](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-maintenancewindow.html) | [aws_ssm_maintenance_window](https://docs.chef.io/inspec/resources/aws_ssm_maintenance_window/) | [aws_ssm_maintenance_windows](https://docs.chef.io/inspec/resources/aws_ssm_maintenance_windows/) |
|  |  | [AWS::SSM::MaintenanceWindowTarget](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-maintenancewindowtarget.html) | [aws_ssm_maintenance_window_target](https://docs.chef.io/inspec/resources/aws_ssm_maintenance_window_target/) | [aws_ssm_maintenance_window_targets](https://docs.chef.io/inspec/resources/aws_ssm_maintenance_window_targets/) |
|  |  | [AWS::SSM::MaintenanceWindowTask](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-maintenancewindowtask.html) | [aws_ssm_maintenance_window_task](https://docs.chef.io/inspec/resources/aws_ssm_maintenance_window_task/) | [aws_ssm_maintenance_window_tasks](https://docs.chef.io/inspec/resources/aws_ssm_maintenance_window_tasks/) |
|  |  | [AWS::SSM::Parameter](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-parameter.html) | [aws_ssm_parameter](https://docs.chef.io/inspec/resources/aws_ssm_parameter/) | [aws_ssm_parameters](https://docs.chef.io/inspec/resources/aws_ssm_parameters/) |
|  |  | [AWS::SSM::PatchBaseline](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-patchbaseline.html) | [aws_ssm_patch_baseline](https://docs.chef.io/inspec/resources/aws_ssm_patch_baseline/) | [aws_ssm_patch_baselines](https://docs.chef.io/inspec/resources/aws_ssm_patch_baselines/) |
|  |  | [AWS::SSM::ResourceDataSync](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-resourcedatasync.html) | No Singular Resources | [aws_ssm_resource_data_syncs](https://docs.chef.io/inspec/resources/aws_ssm_resource_data_syncs/) |
|  |  | Others | [aws_ssm_activation](https://docs.chef.io/inspec/resources/aws_ssm_activation/) |  [aws_ssm_activations](https://docs.chef.io/inspec/resources/aws_ssm_activations/) |
|  |  |  | [aws_ssm_resource_compliance_summary](https://docs.chef.io/inspec/resources/aws_ssm_resource_compliance_summary/) | [aws_ssm_resource_compliance_summaries](https://docs.chef.io/inspec/resources/aws_ssm_resource_compliance_summaries/) |
| Amazon Timestream | Migration & Transfer | [AWS::Transfer::User](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-transfer-user.html) | [aws_transfer_user](https://docs.chef.io/inspec/resources/aws_transfer_user/) | [aws_transfer_users](https://docs.chef.io/inspec/resources/aws_transfer_users/) |
| WAF | Security, Identity, & Compliance | [AWS::WAF::ByteMatchSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-bytematchset.html) | [aws_waf_byte_match_set](https://docs.chef.io/inspec/resources/aws_waf_byte_match_set/) | [aws_waf_byte_match_sets](https://docs.chef.io/inspec/resources/aws_waf_byte_match_sets/) |
|  |  | [AWS::WAF::IPSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-ipset.html) | [aws_waf_ip_set](https://docs.chef.io/inspec/resources/aws_waf_ip_set/) | [aws_waf_ip_sets](https://docs.chef.io/inspec/resources/aws_waf_ip_sets/) |
|  |  | [AWS::WAF::Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-rule.html) | [aws_waf_rule](https://docs.chef.io/inspec/resources/aws_waf_rule/) | [aws_waf_rules](https://docs.chef.io/inspec/resources/aws_waf_rules/) |
|  |  | [AWS::WAF::SizeConstraintSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-sizeconstraintset.html) | [aws_waf_size_constraint_set](https://docs.chef.io/inspec/resources/aws_waf_size_constraint_set/) | [aws_waf_size_constraint_sets](https://docs.chef.io/inspec/resources/aws_waf_size_constraint_sets/) |
|  |  | [AWS::WAF::SqlInjectionMatchSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-sqlinjectionmatchset.html) | [aws_waf_sql_injection_match_set](https://docs.chef.io/inspec/resources/aws_waf_sql_injection_match_set/) | [aws_waf_sql_injection_match_sets](https://docs.chef.io/inspec/resources/aws_waf_sql_injection_match_sets/) |
|  |  | [AWS::WAF::WebACL](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-webacl.html) | [aws_waf_web_acl](https://docs.chef.io/inspec/resources/aws_waf_web_acl/) | [aws_waf_web_acls](https://docs.chef.io/inspec/resources/aws_waf_web_acls/) |
|  |  | [AWS::WAF::XssMatchSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-xssmatchset.html) | [aws_waf_xss_match_set](https://docs.chef.io/inspec/resources/aws_waf_xss_match_set/) | [aws_waf_xss_match_sets](https://docs.chef.io/inspec/resources/aws_waf_xss_match_sets/) |

## Examples 

### Ensure Security Groups disallow FTP

For disallowing FTP, we check that there is no ingress from 0.0.0.0/0 on port 21.  The below sample control loops across all regions, checking all security groups for the account:

```ruby
title 'Test AWS Security Groups Across All Regions For an Account Disallow FTP'

control 'aws-multi-region-security-group-ftp-1.0' do

  impact 1.0
  title 'Ensure AWS Security Groups disallow FTP ingress from 0.0.0.0/0.'

  aws_regions.region_names.each do |region|
    aws_security_groups(aws_region: region).group_ids.each do |security_group_id|
      describe aws_security_group(aws_region: region, group_id: security_group_id) do
        it { should exist }
        it { should_not allow_in(ipv4_range: '0.0.0.0/0', port: 21) }
      end
    end
  end
end
```

### Test that an EC2 instance is running and using the correct AMI

```ruby
    describe aws_ec2_instance(name: 'ProdWebApp') do
      it              { should be_running }
      its('image_id') { should eq 'ami-27a58d5c' }
    end
```

### Ensure all AWS Users have MFA enabled

```ruby
    describe aws_iam_users.where( has_mfa_enabled: false) do
      it { should_not exist }
    end
```

## Properties Applying to All InSpec AWS Resources

### `aws_region`

To provide multi-region support, the `aws_region` property is specified to a resource.  This property affects AWS resources that have a region dependency. For example, security groups.  One special case worth mentioning is the `aws_s3_bucket` resource that updates its region based on the location returned from S3.

The `aws_regions` resource is used to loop across all regions.

```ruby
  aws_regions.region_names.each do |region|
    <use region in other resources here>
  end
```

### `aws_endpoint`

A custom endpoint URL can optionally be specified to resources for testing other compatible providers.  This propagates to the AWS client configuration.  An example is provided below for [Minio](https://github.com/minio/minio) S3 compatible buckets.

```ruby
title 'Test For Minio Buckets Existing at a Custom Endpoint'

endpoint = attribute(:minio_server, value: 'http://127.0.0.1:9000', description: 'The Minio server custom endpoint.')

control 'minio-buckets-1.0' do
  impact 1.0
  title 'Ensure Minio buckets exist.'

  describe aws_s3_bucket(aws_endpoint: endpoint, bucket_name: 'miniobucket') do
    it { should exist }
  end

  describe aws_s3_bucket(aws_endpoint: endpoint, bucket_name: 'notthere') do
    it { should_not exist }
  end
end
```

{{< note >}}

The InSpec AWS assumes full compatibility with the underlying AWS SDK, and unsupported operations cause failures. Hence, depending on the external provider implementation, your mileage may vary!

{{< /note >}}

### `aws_retry_limit` and `aws_retry_backoff`

In certain cases, AWS implements rate-limiting. To mitigate this issue, the `Retry Limit` and `Retry Backoff` can be set in two ways:

#### 1) Environment Variables

Setting `AWS_RETRY_LIMIT` and `AWS_RETRY_BACKOFF` environment variables is implemented at the session level.

```bash
   export AWS_RETRY_LIMIT=5
   export aws_retry_limit=5
```

_Note environment variables are case insensitive._

#### 2) InSpec Control

InSpec AWS resources now support setting the Retry Limit and Retry Backoff at the control level, as shown below.

```ruby
  describe aws_config_recorder(recorder_name: aws_config_recorder_name, aws_retry_limit=5, aws_retry_backoff=5) do
    it { should exist }
    its('recorder_name') { should eq aws_config_recorder_name }
  end
```

 #####The `aws_retry_limit` and `aws_retry_backoff` precedence:

   1. Set at Inspec control level.
   2. Set at Environment level.

[Retry Limit and Retry Backoff documentation](https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/timeout-duration.html)

### `NullResponse`

InSpec AWS resources returns `NullResponse` when an undefined property is tested from version **1.24** onwards instead of raising a `NoMethodError`.

```ruby
describe aws_ec2_instance(instance_id: 'i-12345678') do
  its('fake_property') { should be_nil }
end
# =>   EC2 Instance i-12345678
#          ✔  fake_property is expected to be nil

describe aws_ec2_instance(instance_id: 'i-12345678') do
  its('instance_ID') { should eq 'i-12345678' }
end
# =>  ×  instance_ID is expected to eq "i-12345678"    
#     expected: "i-12345678"
#          got: #<#<Class:0x00007ffc4aa24c68>::NullResponse:0x00007ffc39f16070>    
#     (compared using ==)
```

Prior to version **1.24**.

```ruby
describe aws_ec2_instance(instance_id: 'i-12345678') do
  its('fake_property') { should be_nil }
end
# => EC2 Instance i-12345678
#          ×  fake_property 
#          undefined method `fake_property' for EC2 Instance i-12345678

describe aws_ec2_instance(instance_id: 'i-12345678') do
  its('instance_ID') { should eq 'i-12345678' }
end
# => undefined method `instance_ID' for EC2 Instance i-12345678
```

## Environment and Setup Notes

### Train and InSpec Dependencies

InSpec AWS depends on version 3 of the AWS SDK provided via [Train AWS](https://github.com/inspec/train-aws). InSpec depends on Train AWS, so this is not explicitly listed in the Gemfile here.

### Running a sample profile using Docker

A `Dockerfile` is provided at the root of this resource pack repository.  

```bash
cd inspec-aws
docker build -t inspec-aws -f Dockerfile
docker run -it inspec-aws /bin/bash
export AWS_ACCESS_KEY_ID=<your creds here>
export AWS_SECRET_ACCESS_KEY=<your creds here>
bundle exec inspec exec sample_profile -t aws://
```

If successful, output similar to below code is seen:

```bash
# bundle exec inspec exec sample_profile -t aws://

Profile: AWS InSpec Profile (InSpec AWS Sample Profile)
Version: 0.1.0
Target:  aws://us-east-1

  ✔  aws-vpcs-multi-region-status-check: Check AWS VPCs in all regions have status "available"
     ✔  VPC vpc-1234abcd in eu-north-1 should exist
     ✔  VPC vpc-1234abcd in eu-north-1 should be available
<curtailing> ...


Profile: Amazon Web Services  Resource Pack (inspec-aws)
Version: 0.1.0
Target:  aws://us-east-1

     No tests were executed.

Profile Summary: 1 successful control, 0 control failures, 0 controls skipped
Test Summary: 50 successful, 0 failures, 0 skipped
```

### Running a single unit test

```bash
rake test TEST=inspec-aws/test/unit/resources/aws_alb_test.rb
```

The above example is for running the `aws_alb_test.rb` file.

### Running the unit and integration tests

Run the linting and unit tests via the below:

```bash
$ bundle exec rake
Running RuboCop...
Inspecting 2 files
..

2 files inspected, no offenses detected
/Users/spaterson/.rubies/ruby-2.4.3/bin/ruby -I"lib:libraries:test/unit" -I"/Users/spaterson/.rubies/ruby-2.4.3/lib/ruby/gems/2.4.0/gems/rake-12.3.1/lib" "/Users/spaterson/.rubies/ruby-2.4.3/lib/ruby/gems/2.4.0/gems/rake-12.3.1/lib/rake/rake_test_loader.rb" "test/unit/resources/aws_vpc_test.rb"
Run options: --seed 64195

# Running:

.................

Fabulous run in 0.253300s, 67.1141 runs/s, 51.3225 assertions/s.

17 runs, 13 assertions, 0 failures, 0 errors, 0 skips
bundle exec inspec check /Users/spaterson/Documents/workspace/aws/inspec-aws
Location:    /Users/spaterson/Documents/workspace/aws/inspec-aws
Profile:     inspec-aws
Controls:    0
Timestamp:   2018-11-29T15:02:33+00:00
Valid:       true

  !  No controls or tests were defined.

Summary:     0 errors, 1 warnings
```

Conversely, run using within a docker container, using the make file:

To run unit tests and linting:

````bash
make sure

````

Will result in...

````bash
make sure

docker-compose run --rm builder 
Running RuboCop...
Inspecting 68 files
....................................................................

68 files inspected, no offenses detected
/usr/local/bin/ruby -I"lib:libraries:test/unit" -I"/usr/local/bundle/gems/rake-12.3.3/lib" "/usr/local/bundle/gems/rake-12.3.3/lib/rake/rake_test_loader.rb" "test/unit/resources/aws_alb_test.rb" "test/unit/resources/aws_auto_scaling_group_test.rb" "test/unit/resources/aws_cloudformation_stack_test.rb" "test/unit/resources/aws_cloudtrail_trail_test.rb" "test/unit/resources/aws_cloudtrail_trails_test.rb" "test/unit/resources/aws_cloudwatch_alarm_test.rb" "test/unit/resources/aws_cloudwatch_log_metric_filter_test.rb" "test/unit/resources/aws_config_delivery_channel_test.rb" "test/unit/resources/aws_config_recorder_test.rb" "test/unit/resources/aws_dynamodb_table_test.rb" "test/unit/resources/aws_ebs_volume_test.rb" "test/unit/resources/aws_ebs_volumes_test.rb" "test/unit/resources/aws_ec2_instance_test.rb" "test/unit/resources/aws_ec2_instances_test.rb" "test/unit/resources/aws_ecr_test.rb" "test/unit/resources/aws_ecs_cluster_test.rb" "test/unit/resources/aws_eks_cluster_test.rb" "test/unit/resources/aws_eks_clusters_test.rb" "test/unit/resources/aws_elb_test.rb" "test/unit/resources/aws_flow_log_test.rb" "test/unit/resources/aws_hosted_zones_test.rb" "test/unit/resources/aws_iam_account_alias_test.rb" "test/unit/resources/aws_iam_group_test.rb" "test/unit/resources/aws_iam_password_policy_test.rb" "test/unit/resources/aws_iam_policy_test.rb" "test/unit/resources/aws_iam_role_test.rb" "test/unit/resources/aws_iam_root_user_test.rb" "test/unit/resources/aws_iam_saml_provider_test.rb" "test/unit/resources/aws_iam_user_test.rb" "test/unit/resources/aws_kms_key_test.rb" "test/unit/resources/aws_kms_keys_test.rb" "test/unit/resources/aws_launch_configuration_test.rb" "test/unit/resources/aws_organizations_member_test.rb" "test/unit/resources/aws_rds_instance_test.rb" "test/unit/resources/aws_rds_instances_test.rb" "test/unit/resources/aws_region_test.rb" "test/unit/resources/aws_regions_test.rb" "test/unit/resources/aws_route_table_test.rb" "test/unit/resources/aws_route_tables_test.rb" "test/unit/resources/aws_s3_bucket_object_test.rb" "test/unit/resources/aws_s3_bucket_test.rb" "test/unit/resources/aws_s3_buckets_test.rb" "test/unit/resources/aws_security_group_test.rb" "test/unit/resources/aws_security_groups_test.rb" "test/unit/resources/aws_sns_subscription_test.rb" "test/unit/resources/aws_sns_topic_test.rb" "test/unit/resources/aws_sns_topics_test.rb" "test/unit/resources/aws_sqs_queue_test.rb" "test/unit/resources/aws_sts_caller_identity_test.rb" "test/unit/resources/aws_subnet_test.rb" "test/unit/resources/aws_subnets_test.rb" "test/unit/resources/aws_vpc_test.rb" "test/unit/resources/aws_vpcs_test.rb" 
Run options: --seed 22010

# Running:

..............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................

Fabulous run in 4.613042s, 155.6457 runs/s, 172.3375 assertions/s.

718 runs, 795 assertions, 0 failures, 0 errors, 0 skips

````

To run the full suite of tests, run

````bash
make doubly_sure

````

This test runs the unit tests, creates the target infrastructure, and runs the intergration tests.  If successful, the test  automatically destroy everything.  If it fails, it will keep the environment up, testing then can be achieved by running:

````bash
make int_test
````

The AWS credentials can either be supplied via environmental variables or files located on ./aws folder.

This requires docker, docker-compose and make, see [Three Musketeers Pattern](https://3musketeers.io/docs/make.html) for details.

Running the integration tests (after `setup_integration_tests`):

```bash
$ bundle exec rake test:run_integration_tests
----> Run
bundle exec inspec exec test/integration/verify --attrs test/integration/build/aws-inspec-attributes.yaml; rc=$?; if [ $rc -eq 0 ] || [ $rc -eq 101 ]; then exit 0; else exit 1; fi

Profile: Amazon Web Services  Resource Pack (inspec-aws)
Version: 0.1.0
Target:  aws://eu-west-2

  ✔  aws-vpc-1.0: Ensure AWS VPC has the correct properties.
     ✔  VPC vpc-0373aeb7284407ffd should exist
     ✔  VPC vpc-0373aeb7284407ffd should not be default
     ✔  VPC vpc-0373aeb7284407ffd cidr_block should eq "10.0.0.0/27"
     ✔  VPC vpc-0373aeb7284407ffd instance_tenancy should eq "dedicated"
     ✔  VPC vpc-0373aeb7284407ffd vpc_id should eq "vpc-0373aeb7284407ffd"
     ✔  VPC vpc-0373aeb7284407ffd state should eq "available"
     ✔  VPC vpc-0373aeb7284407ffd dhcp_options_id should eq "dopt-f557819d"
     ✔  VPC default should exist
     ✔  VPC default should be default
     ✔  VPC default vpc_id should eq "vpc-1ea06476"
     ✔  VPC vpc-0373aeb7284407ffd should exist
     ✔  VPC vpc-0373aeb7284407ffd should not be default
     ✔  VPC vpc-0373aeb7284407ffd vpc_id should eq "vpc-0373aeb7284407ffd"
...

Profile: Amazon Web Services  Resource Pack (inspec-aws)
Version: 0.1.0
Target:  aws://eu-west-2

     No tests were executed.

Profile Summary: 50 successful controls, 0 control failures, 3 controls skipped
Test Summary: 602 successful, 0 failures, 18 skipped
```

## FAQ

### Failure running "inspec exec" on my AWS profile

If an error occurs when running "inspec exec" on a newly created AWS profile, check that the AWS transport is specified as below:

```bash
inspec exec . -t aws://
```

If a method missing error occurs and all the steps documented above is followed try running the following command within the profile directory:

```bash
inspec vendor --overwrite
```

## Support

The InSpec AWS resources are community-supported. For bugs and features, please open a GitHub issue and label it appropriately.

## Kudos

This work builds on the InSpec 2 AWS resources that are originally shipped as part of InSpec.
