# capistrano-scm-s3artifact

A s3artifact strategy for Capistrano 3 to deploy tarball from s3.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-scm-s3artifact', :git => 'https://github.com/arwineap/capistrano-scm-s3artifact'
```

## Usage

Set `s3artifact` as `scm` option in your `config/deploy.rb`:

```ruby
set :scm, :s3artifact
```

Build a release package of your project and upload it to the s3 bucket you run store artifacts in:

```shell
tar czf /tmp/v1.0.0.tar.gz *
aws s3 cp /tmp/v1.0.0.tar.gz s3://s3-bucket-name/v1.0.0.tar.gz
```

And then, deploy it:

```shell
cap deploy package=s3://s3-bucket-name/v1.0.0.tar.gz
```

If your s3 object is versioned you can specify the version to grab by setting an environment variable with the path to a file specifying the version
`artifact_version_file=/path/to/artifact/version/file`


The aws credentials are provided by a iam profile role

The revision setting used by `set_current_revision` is set by the basename of the tarball. Optionally it may also be set via a file by setting an environment file `version_file=/path/to/version/file`



## Attributions
This was essentially a fork of:
https://github.com/ziguzagu/capistrano-scm-tar

And modified to replace this capistrano2 strategy:
https://github.com/cluesque/capistrano-s3

## License

The MIT License (MIT)
