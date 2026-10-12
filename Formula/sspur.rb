class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.7.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.7.1/sspur-v0.7.1-aarch64-apple-darwin.tar.gz"
      sha256 "a2a5a713f7504e0c840a302db639afd1fec765032c17939ecc77a835286f748a"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.7.1/sspur-v0.7.1-x86_64-apple-darwin.tar.gz"
      sha256 "e5fdd72d1757ca3c6af731d68c5213301db1e27a0b6cb163105e2ee7d023d12f"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.7.1/sspur-v0.7.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f05b89b1efffdbe93e91d5f3ef2307d0eff7bc1923bcb894cd290dfa066d3c10"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.7.1/sspur-v0.7.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "32f6835793598d1e3a1dd0d5f8e4c02378a221691de0eafbda27cdc2aef63a52"
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
