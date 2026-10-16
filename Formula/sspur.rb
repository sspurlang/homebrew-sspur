class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.12.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.12.0/sspur-v0.12.0-aarch64-apple-darwin.tar.gz"
      sha256 "8ff3cfd964bc6f74da89b02277d381fecba28bb3ad1cadabf6f0944d9432a9a1"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.12.0/sspur-v0.12.0-x86_64-apple-darwin.tar.gz"
      sha256 "1224f084e1fb18e3a41d37a66e9417ad3d45ec9cba889cdd15b8ecf6d453a732"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.12.0/sspur-v0.12.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "de484253c28e5f6f46b705597b2ad63b1c7d56f41d3d1ee531fc483e4bac5060"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.12.0/sspur-v0.12.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "318813555c54f5221e24b8122632735c5edd925e82049996dfd98f519b0e0332"
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
