# -*- mode: ruby -*-
namespace :s3artifact do

  task :create_release do
    if ! ENV['package']
      abort "require 'package=<s3://s3-bucket-name/archive.tar.gz>' environment variable by s3artifact scm"
    end

    rev_version = nil
    if ENV['rev_version_file']
      if File.file?(ENV['rev_version_file'])
        rev_version = `cat #{ENV['rev_version_file']}`.strip
      end
    end

    artifact_version = nil
    if ENV['artifact_version_file']
      if File.file?(ENV['artifact_version_file'])
        artifact_version = `cat #{ENV['artifact_version_file']}`.strip
      end
    end

    on release_roles :all do
      pkg = ENV['package']
      if rev_version
        rev = rev_version
      else
        rev = (File.basename(pkg).split('.') - ['tar', 'gz', 'tgz']).join('.')
      end
      tmp = capture 'mktemp'

      # download artifact
      s3_get_command = "aws s3api get-object "
      if artifact_version
        s3_get_command = s3_get_command + "--version-id #{artifact_version} "
      end
      s3_get_command = s3_get_command + "--bucket #{URI(pkg).host} --key #{URI(pkg).path.sub(/^\//, '')} #{tmp}"
      execute(s3_get_command)

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
