class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.7.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.7.0/sspur-v0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "6f66cfa195d2f2fa905794135f9e14c864b10e1d4590c59fbfcb3580e5845c8d"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.7.0/sspur-v0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "8ded2aa34d9fd584f07bcd3efd4b1ea69c1b2b6f6abd0d4fd142c9126c7e03b4"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.7.0/sspur-v0.7.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "37ea21714fe5f2660f31c7b292b5800fc8dcd1fea229d2a286cc4cd9134abc08"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.7.0/sspur-v0.7.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "586010452140fb1f4740dd9bc542f6812faab08a879e8348d0a49fe61dd66c28"
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
