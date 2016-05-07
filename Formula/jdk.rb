class JdkDownloadStrategy < CurlDownloadStrategy
  def _curl_opts
    super << "--cookie" << "oraclelicense=accept-securebackup-cookie"
  end
end

class Jdk < Formula
  homepage "http://www.oracle.com/technetwork/java/javase/downloads/index.html"

  version "1.8.0-91"
  if OS.linux?
    url "http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz",
      :using => JdkDownloadStrategy
    sha256 "6f9b516addfc22907787896517e400a62f35e0de4a7b4d864b26b61dbe1b7552"
  elsif OS.mac?
    url "jdk", :using => JdkDownloadStrategy
  else
    raise "Unknown operating system"
  end

  def install
    prefix.install Dir["*"]
  end

  def caveats; <<-EOS.undent
    By installing and using JDK you agree to the
    Oracle Binary Code License Agreement for the Java SE Platform Products and JavaFX
    http://www.oracle.com/technetwork/java/javase/terms/license/index.html
    EOS
  end

  test do
    system "#{bin}/java", "-version"
    system "#{bin}/javac", "-version"
  end
end
