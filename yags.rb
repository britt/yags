require 'tmpdir'
require 'fileutils' 

source = ARGV[0]
destination = ARGV[1]

begin
  tempdir = Dir.tmpdir
  Dir.chdir(tempdir)
  repo_directory = source.match(/[:\/]([^\/:]+)\.git/)[1]
  repo = File.expand_path(File.join(tempdir, repo_directory))
  system "git clone #{source}"
  Dir.chdir(repo_directory)
  system "git remote add target #{destination}"
  system "git push target"
ensure
  Dir.chdir '..'
  FileUtils.rm_rf(repo) if repo
end