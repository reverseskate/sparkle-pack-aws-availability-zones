Gem::Specification.new do |s|
  s.name = 'sparkle-pack-aws-availability-zones'
  s.version = '0.1.1'
  s.licenses = ['MIT']
  s.summary = 'AWS Availability Zone SparklePack'
  s.description = 'SparklePack to detect AWS availability zones for configured region and provide them as an array'
  s.authors = ['Michael F. Weinberg']
  s.email = 'support@heavywater.io'
  s.homepage = 'http://sparkleformation.io'
  s.files = Dir[ 'lib/sparkleformation/registry/*' ] + %w(sparkle-pack-aws-availability-zones.gemspec lib/sparkle-pack-aws-availability-zones.rb)
  s.add_runtime_dependency 'aws-sdk-core', '~> 2.2'
  s.add_runtime_dependency 'json', '~> 1.8'
end
