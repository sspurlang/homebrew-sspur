class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/sspurlang/sspur"
  version "1.0.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/sspurlang/sspur/releases/download/v1.0.0/sspur-v1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "071ef77d8b04da209c5203a015313c97098b70593ee8dfb560764e6cad6ff217"
    end
    on_intel do
      url "https://github.com/sspurlang/sspur/releases/download/v1.0.0/sspur-v1.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "34a3f31fc5810b70ebfcdbe29f2bb2f873b8fcf752d5a6cb3f9e7f49966a7c90"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/sspurlang/sspur/releases/download/v1.0.0/sspur-v1.0.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b447bea59ba1350f003cde059321ad90f0d0dfff11772258d4b92eff613ffa69"
    end
    on_intel do
      url "https://github.com/sspurlang/sspur/releases/download/v1.0.0/sspur-v1.0.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1d94d196571395d8b8a772f734d3d60605221aaea8c17f156cd10a9c43d482dd"
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
