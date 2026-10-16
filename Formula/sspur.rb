class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.12.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.12.1/sspur-v0.12.1-aarch64-apple-darwin.tar.gz"
      sha256 "68b7328ce34a72a2d7677954cf11a394bbfe1c77aba3952b9648f5552e26a0a3"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.12.1/sspur-v0.12.1-x86_64-apple-darwin.tar.gz"
      sha256 "0d590683d744029c39861fe55dd1e092461baf98e4697130a3baeec76724560f"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.12.1/sspur-v0.12.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "69875baae210fbcc2cd5ccf3f0af6a6f54c6e0fe1aeeb0c39f10715692a1df36"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.12.1/sspur-v0.12.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "462cfbd06958dbe5ecd0e92196d7ba1a38efb1ab48a6e10b6612301e1263d954"
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
