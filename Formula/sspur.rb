class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/sspurlang/sspur"
  version "0.15.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/sspurlang/sspur/releases/download/v0.15.0/sspur-v0.15.0-aarch64-apple-darwin.tar.gz"
      sha256 "3c114ee17587140ee067c4820f88cebf3d8fa184ad24c7277ec553e536407eb0"
    end
    on_intel do
      url "https://github.com/sspurlang/sspur/releases/download/v0.15.0/sspur-v0.15.0-x86_64-apple-darwin.tar.gz"
      sha256 "9e0b8e70e1f3446c417afacca4c0fe5af02c95031e4b65b0b4d1da35f7eb7c8e"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/sspurlang/sspur/releases/download/v0.15.0/sspur-v0.15.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "361246c99d20f2c51c4b72c23fd59049258efad3f72f63c5741727972b140956"
    end
    on_intel do
      url "https://github.com/sspurlang/sspur/releases/download/v0.15.0/sspur-v0.15.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9844b7290d6ff3d8d075b524e241cacb15f76fadf1672e827898e2e9103f0b0e"
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
