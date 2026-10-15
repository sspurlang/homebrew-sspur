class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.11.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.11.0/sspur-v0.11.0-aarch64-apple-darwin.tar.gz"
      sha256 "d03925aaadf9fc058b023c237b390f6f53b18ba7487fd786e5809ab12a87db5b"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.11.0/sspur-v0.11.0-x86_64-apple-darwin.tar.gz"
      sha256 "57f41789f07d0feeaf23de41a1b07fd8c477480f006b7e2a979d19ac6c7c890e"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.11.0/sspur-v0.11.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5d88bbaeb8e3c6e57ab6faa6ce21071c4a8e474e8df5ca9a0448db461d8cef80"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.11.0/sspur-v0.11.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f18268772a19b773d26a2681b4d66f058aff6bfdc198ff194b1155244f95c0b1"
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
