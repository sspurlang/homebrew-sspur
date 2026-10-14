class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.9.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.9.0/sspur-v0.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "b11f4d7b78211e2d277c5f004ce307caf00a8eb9cc77b1961123b38c4b0c87ff"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.9.0/sspur-v0.9.0-x86_64-apple-darwin.tar.gz"
      sha256 "531165b5657921a88ed2817d3bb068a12ac759a3da5bf5c69a29bdce513e1d36"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.9.0/sspur-v0.9.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6a2b9fe2d677be7b5a738ae2cadc93b05d05790766a72fcbc70468154eb6ab66"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.9.0/sspur-v0.9.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "04b8865f46cc230bf37365adef3b0069d0c918cba74de75f32c13e4bfaba3744"
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
