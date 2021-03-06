require "language/node"

class Elixirscript < Formula
  desc "Elixir to JavaScript compiler"
  homepage "https://github.com/bryanjos/elixirscript"
  url "https://github.com/bryanjos/elixirscript/archive/v0.18.0.tar.gz"
  sha256 "1c9518a61abc2b587bd392bdaecfce75e6c399e5c5e21d64ed818f340a25a0ad"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "076b2b0885465bef7edc8e6008dec1daca35ac6691004d19993fea3eabdae78d" => :el_capitan
    sha256 "3d22354f4856dbaf811a43af66cb50c462313179f76d69408aa065486d136f75" => :yosemite
    sha256 "69644a1a22e47ae63f8cf186e213a0e3b305acc61d9ac5daa1a7e1d8b01356e5" => :mavericks
  end

  depends_on "elixir" => :build
  depends_on "node" => :build

  def install
    system "mix", "local.hex", "--force"
    system "mix", "deps.get"
    system "npm", "install", *Language::Node.local_npm_install_args
    system "mix", "std_lib"
    system "mix", "clean"
    system "mix", "compile"
    system "mix", "dist"
    bin.install "elixirscript"
    prefix.install Dir["priv/*"], "LICENSE"
  end

  test do
    src_path = testpath/"Example.exjs"
    src_path.write <<-EOS.undent
      :keith
    EOS

    out_path = testpath/"dest"
    system "elixirscript", src_path, "-o", out_path

    assert File.exist?(out_path)
    assert_match("keith", (out_path/"Elixir.ElixirScript.Temp.js").read)
  end
end
