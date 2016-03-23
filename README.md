# sparkle-pack-aws-availability-zones
SparklePack to auto-detect Availability Zones for current Region and return them as an array.
h/t to [techshell](https://github.com/techshell) for this approach.

## Use Cases
This SparklePack adds a registry entry that uses the AWS SDK to detect the Availability Zones for your region (based on `ENV['AWS_REGION']`) and returns them as an array. It is useful for any multi-AZ implementation, but especially valuable for creating a codebase that works in any AWS region.

## Usage
Add the pack to your Gemfile and .sfn:

Gemfile:
```ruby
source 'https://rubygems.org'

gem 'sfn'
gem 'sparkle-pack-aws-availability-zones'
```

.sfn:
```ruby
Configuration.new do
  sparkle_pack [ 'sparkle-pack-aws-availability-zones' ]
  ...
end
```

In a SparkleFormation Template/Component/Dynamic:
```ruby
zones = registry!(:zones)
```
`zones` will be an array of Availability Zones, e.g. `[ 'us-west-2a', 'us-west-2b', 'us-west-2d' ]`

This is useful for consistently creating subnets:
```ruby
zones.each do |zone|
  resource("public_#{zone.gsub('-', '_')}_subnet".to_sym) do
    type 'AWS::EC2::Subnet'
    properties do
      availability_zone zone
      cidr_block ref!("public_#{zone.gsub('-', '_')}_cidr".to_sym)
      vpc_id ref!(vpc_id)
    end
  end
end
```

You can, of course, work with a subset of the Availability Zones as well:

Return a single AZ:
```ruby
zone = registry!(:zones).first
zone = registry!(:zones)[2]
zone = registry!(:zones).sample
```
When returning an index, remember that AWS regions offer varying numbers of Availability Zones.

Set a maximum number of Availability Zones:
```ruby
zones = registry!(:zones).take(3)
```
