class Zenith < Formula
  desc "An architecture linter for monorepos"
  homepage "https://github.com/feds01/zenith"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feds01/zenith/releases/download/v0.4.0/zenith-aarch64-apple-darwin.tar.xz"
      sha256 "a9149b61a6d6e2b28c311453d8449a24efa9c14b2b88ef7f0eedeeaa3ad9e666"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feds01/zenith/releases/download/v0.4.0/zenith-x86_64-apple-darwin.tar.xz"
      sha256 "d2283f2acd632581901b7d059919fa99dea6f41b5e0988c703c3295bed8cece8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feds01/zenith/releases/download/v0.4.0/zenith-aarch64-unknown-linux-musl.tar.xz"
      sha256 "22081a3fc6ce60dcd134d89b92fd0122b9ff1b1287002b8890ed457390b264b8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feds01/zenith/releases/download/v0.4.0/zenith-x86_64-unknown-linux-musl.tar.xz"
      sha256 "cdbd4408d666f3b8ecc3fca14450218e60288977c6fd823662c90a288fc24dd7"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "zenith"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "zenith"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "zenith"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "zenith"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
