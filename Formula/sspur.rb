class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.13.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.13.0/sspur-v0.13.0-aarch64-apple-darwin.tar.gz"
      sha256 "edd5ed3a528233cfe15b40f240d95ec1b3c917564158fdccddf0cffdf3efb2bb"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.13.0/sspur-v0.13.0-x86_64-apple-darwin.tar.gz"
      sha256 "b48567d5c1a4d5104ff48c7f6baa274c418be69e14647ec4c4472fb8bf50fb1d"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.13.0/sspur-v0.13.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b9ba8fce9fde20c3ae2fd8361db06810b0f99f1e85cbee477df0998a8e13f164"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.13.0/sspur-v0.13.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a932e20e1b86dc1764cb907ab38f876ae8a49dac82e725306e387df66b4fcc14"
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
