# Documentation: https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Accumulo < Formula
  desc "Hadoop based sorted, distributed key/value store"
  homepage "https://accumulo.apache.org/"
  url "https://www.apache.org/dyn/closer.lua/accumulo/1.7.1/accumulo-1.7.1-bin.tar.gz"
  sha256 "8312f30fceb2318dcde5ee667e49f060087d9327e015084a51d51cbe5a7e9f95"

  depends_on :java => "1.7+"
  depends_on "hadoop"

  def install
    rm_f Dir["bin/*.cmd", "bin/*.ps1"]
    libexec.install %w[bin conf docs examples lib logs proxy test]
    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", Language::Java.java_home_env)
  end

  def caveats; <<-EOS.undent
    Please read INSTALL.md and refer hbase.rb to properly implement default configuration on mac
    EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test accumulo`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
