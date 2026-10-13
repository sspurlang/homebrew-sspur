class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.8.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.8.1/sspur-v0.8.1-aarch64-apple-darwin.tar.gz"
      sha256 "627916773e8479168df18c200f27aaf3ec63e00b8e0ad97be6139fef8574098d"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.8.1/sspur-v0.8.1-x86_64-apple-darwin.tar.gz"
      sha256 "62a4bc1dce04baf89c409c77c094b232a027361225b2259eb2f67c110012a16f"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.8.1/sspur-v0.8.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ea3e056435cc41c2132ace1e92a1b4295c4e7ae46f33b3f54370202d79b00e77"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.8.1/sspur-v0.8.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e5012299ffe78517d6fba368ddfb1d3ffe5ea3c1f849c0926e95fad0de0e1bca"
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
