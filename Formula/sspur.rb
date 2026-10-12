class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.8.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.8.0/sspur-v0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "75009a8a3dd04c2e95cdf3a7a8683eca10d56b10430399d42f2cbeb67a0e6d84"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.8.0/sspur-v0.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "c483ffd318aa54fe625e8146609295c3339f5f560cdb6491af54621da603c429"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.8.0/sspur-v0.8.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "81fa92d8f4db4885734ed736a5603d28e7b81d49dd98cb6a77312f4a3ed6bf85"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.8.0/sspur-v0.8.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a44ef01ec243d263a34e2147e1ff29b47769530565be6149f84d975294f960e6"
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
