class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/sspurlang/sspur"
  version "0.13.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/sspurlang/sspur/releases/download/v0.13.1/sspur-v0.13.1-aarch64-apple-darwin.tar.gz"
      sha256 "fec7694221da5f47ef8fc6aeebec802f85037c29cf8d973b0b55a3510f3b2a0b"
    end
    on_intel do
      url "https://github.com/sspurlang/sspur/releases/download/v0.13.1/sspur-v0.13.1-x86_64-apple-darwin.tar.gz"
      sha256 "889bfee0b75ab56746734f468c5c93342b4f05abba8e6452128145118fe5b62c"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/sspurlang/sspur/releases/download/v0.13.1/sspur-v0.13.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b082cf2d8bb1408108d87ea6a7bdbcbf720cf408cd7f53d6fea4ebdbf6b845ea"
    end
    on_intel do
      url "https://github.com/sspurlang/sspur/releases/download/v0.13.1/sspur-v0.13.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "28d9a8ae217c3dcbed71d82bfbe01507d4596bae2b948d5e7eb0caedea75ca94"
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
