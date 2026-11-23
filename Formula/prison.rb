class Prison < Formula
  desc "Run processes in a per-project micro-VM, isolated from your machine"
  homepage "https://github.com/gjazali/prison"
  version "0.9.7"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/gjazali/prison/releases/download/v0.9.7/prison-v0.9.7-darwin-arm64.tar.gz"
      sha256 "bf231706ee8a83d0990777035ed1e98724089b8ef62bf168188b7709d81817dd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/gjazali/prison/releases/download/v0.9.7/prison-v0.9.7-linux-amd64.tar.gz"
      sha256 "9bf8dbf1df77ff26dd1e79a9a2268aa988353d00bede04510ba46ea37d140265"
    end
    on_arm do
      url "https://github.com/gjazali/prison/releases/download/v0.9.7/prison-v0.9.7-linux-arm64.tar.gz"
      sha256 "4dd8782bf785b12eadc0507c899bea3f834db6d99bb88d00da9b6f0c473851f5"
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
