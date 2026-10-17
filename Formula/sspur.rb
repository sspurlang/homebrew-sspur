class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/sspurlang/sspur"
  version "0.14.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/sspurlang/sspur/releases/download/v0.14.0/sspur-v0.14.0-aarch64-apple-darwin.tar.gz"
      sha256 "c3d1ac9ca6d53275d8e848b80b38b80df415ba97e403914715184d76c29597ad"
    end
    on_intel do
      url "https://github.com/sspurlang/sspur/releases/download/v0.14.0/sspur-v0.14.0-x86_64-apple-darwin.tar.gz"
      sha256 "a36c8c82972f41aae997fe7bdce73d5d79a1e0b14575011672ef69a18459b19c"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/sspurlang/sspur/releases/download/v0.14.0/sspur-v0.14.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c11936050885ea9e59d6e60e69b7b473e1c340fbabf8eab5cac7b3ed48f65dfc"
    end
    on_intel do
      url "https://github.com/sspurlang/sspur/releases/download/v0.14.0/sspur-v0.14.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bbdcee7bd2074e2131ce41aa5c347395c672e7b67bd063c8efb77ac562636cd1"
    end
  end

  depends_on "z3" => :recommended

  def install
    bin.install "sspur"
    doc.install "README.md", "CHANGELOG.md"
  end

  def caveats
    <<~EOS
      SSPUR compiles to native code through clang. On macOS it comes with
      the Xcode Command Line Tools (xcode-select --install).
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sspur --version")
    (testpath/"t.ssp").write <<~SSP
      fn add(a: Int, b: Int) -> Int
      = a + b

      test adds = add(2, 3) == 5
    SSP
    assert_match "1 passed, 0 failed", shell_output("#{bin}/sspur test --interp #{testpath}/t.ssp")
  end
end
