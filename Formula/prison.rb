class Prison < Formula
  desc "Run processes in a per-project micro-VM, isolated from your machine"
  homepage "https://github.com/gjazali/prison"
  version "0.9.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gjazali/prison/releases/download/v#{version}/prison-v#{version}-darwin-arm64.tar.gz"
      sha256 "99baa93f02c6bc392d652b2f8017a4733811cb9f04b0b94ce83b1d27adbf9280"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gjazali/prison/releases/download/v#{version}/prison-v#{version}-linux-amd64.tar.gz"
      sha256 "e37784c12ab3a06fcb0ea8c43f77aa706bc48037b15f31007207d40324e4d1cf"
    end
    on_arm do
      url "https://github.com/gjazali/prison/releases/download/v#{version}/prison-v#{version}-linux-arm64.tar.gz"
      sha256 "7c6179d01d7b5fce4b203184017e1d2d1dede3c21f4245d434dbd7d10949d9a5"
    end
  end

  def install
    bin.install "prison"
  end

  def caveats
    if OS.mac?
      <<~EOS
        Prison requires Apple's Container runtime on macOS:
          brew install container
          container system start --enable-kernel-install
      EOS
    else
      <<~EOS
        Prison on Linux requires KVM (/dev/kvm), Firecracker, BuildKit,
        nfs-kernel-server, and nftables. Run `prison doctor` to check setup.
      EOS
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prison --version")
  end
end
