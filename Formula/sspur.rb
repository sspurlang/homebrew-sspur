class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.10.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.10.0/sspur-v0.10.0-aarch64-apple-darwin.tar.gz"
      sha256 "afb9049c0d3bbfa17755d669f040f504cb22b3556414e0a2532e5ed9a03d5dd6"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.10.0/sspur-v0.10.0-x86_64-apple-darwin.tar.gz"
      sha256 "16fea058a7e733f124e0a2ff90efced1f329b55647be2d503c90611e172e68ff"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.10.0/sspur-v0.10.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f288f65ad36f266b3388c94725172cb598b5a7d422842f1de9b3d0c862d6b757"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.10.0/sspur-v0.10.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "17a56dca2131396846d12ace267fb2bda5a666e8f30309d75120eb9bc1d63ca0"
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
