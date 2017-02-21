# -*- mode: ruby -*-
namespace :s3artifact do

  task :create_release do
    if ! ENV['package']
      abort "require 'package=<s3://s3-bucket-name/archive.tar.gz>' environment variable by s3artifact scm"
    end

    artifact_version = nil
    if ENV['version_file']
      if File.file?(ENV['version_file'])
        artifact_version = `cat #{ENV['version_file']}`.strip
      end
    end

    on release_roles :all do
      pkg = ENV['package']
      if artifact_version
        rev = artifact_version
      else
        rev = (File.basename(pkg).split('.') - ['tar', 'gz', 'tgz']).join('.')
      end
      tmp = capture 'mktemp'

      # download artifact
      execute("aws s3 --quiet cp #{pkg} #{tmp}")

      # expand tarball
      execute :mkdir, '-p', release_path
      execute :tar, '-xzpf', tmp, '-C', release_path
      set :current_revision, rev

      # cleanup
      execute :rm, tmp
    end
  end

  task :check
  task :set_current_revision

end
