class MysqlConnectorJava < Formula
  desc "MySQL database connector for Java applications"
  homepage "https://dev.mysql.com/downloads/connector/cpp/"
  url "http://cdn.mysql.com//Downloads/Connector-J/mysql-connector-java-5.1.39.tar.gz"
  sha256 "ad710b3900cae3be94656825aa70319cf7a96e1ad46bf93e07275f3606f69447"

  bottle :unneeded

  depends_on "java"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
