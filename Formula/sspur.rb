class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.6.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.6.0/sspur-v0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "061d2740bec837c1b1ce22fb03bb128e8c91b89cc69759a5479bf82733f46fea"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.6.0/sspur-v0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "49ba33be1ff20505191627d641f2ad50c796c13dd07908a09e8c9a14cb5da06c"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.6.0/sspur-v0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "30bdadd1a307c03403170f884d119f2e4546eae80fab19a62b8c12c49d96f512"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.6.0/sspur-v0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cbe8055d112e9fb3da23d47d6876fe71807bfb15dc4311c050927063e87dd534"
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
