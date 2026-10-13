class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.8.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.8.2/sspur-v0.8.2-aarch64-apple-darwin.tar.gz"
      sha256 "330f81127b0fe2a50fe284db468f89a030d4d8fca006698b84268d453ba6af6b"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.8.2/sspur-v0.8.2-x86_64-apple-darwin.tar.gz"
      sha256 "f0099b52e4bff4f23f76319d6f59d216d169e5605c93fd137328b69f3ca5fb71"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.8.2/sspur-v0.8.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ed8f9475ebc3c8e106daa6e011a1717094b73d81744a122f69fc582c30800628"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.8.2/sspur-v0.8.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b7ed3f67d15b31822fa94ec79f89818c2da963bdcb8126dc659c0f06da792956"
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
