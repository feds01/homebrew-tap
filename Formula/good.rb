class Good < Formula
  desc "Faster golangci-lint fork"
  homepage "https://github.com/feds01/good"
  version "4301"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/feds01/good/releases/download/good-1c29c4631271/good-1c29c4631271-darwin-arm64.tar.gz"
      sha256 "5ba4e56ffe1d7247542f2021e3d843e18cb9099bea74b4752706e5cdcfc00c35"
    end
    on_intel do
      url "https://github.com/feds01/good/releases/download/good-1c29c4631271/good-1c29c4631271-darwin-amd64.tar.gz"
      sha256 "c7b1d45e5cdc38d057716cd550a76c1c8824a62967ba22e396d38670f1b2c693"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/feds01/good/releases/download/good-1c29c4631271/good-1c29c4631271-linux-amd64.tar.gz"
      sha256 "1980ea6982daba2b622b69ba2245b957b8592597a1233aadb1c77bd2dba3c3c9"
    end
  end

  def install
    bin.install "good"
  end

  test do
    assert_match "good-1c29c4631271", shell_output("#{bin}/good version")
  end
end
