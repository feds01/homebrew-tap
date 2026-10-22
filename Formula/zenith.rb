class Zenith < Formula
  desc "An architecture linter for monorepos"
  homepage "https://github.com/feds01/zenith"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feds01/zenith/releases/download/v0.3.0/zenith-aarch64-apple-darwin.tar.xz"
      sha256 "2977821acab9b803a7db67c7dd44c67169ec123deb9861040f28ead1e4933cf6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feds01/zenith/releases/download/v0.3.0/zenith-x86_64-apple-darwin.tar.xz"
      sha256 "c90c5a6013196af89e0fcfc45a3645aabad05d82f0bea1dc922235afe0ab9cf6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feds01/zenith/releases/download/v0.3.0/zenith-aarch64-unknown-linux-musl.tar.xz"
      sha256 "3d8a6ed6981bd30cf9c70c26cbfd11530c2240d14ed2e281730f2921c27ed6bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feds01/zenith/releases/download/v0.3.0/zenith-x86_64-unknown-linux-musl.tar.xz"
      sha256 "eee75043a3ef7a38be5d96bbd3aced429cb2eeafa14c9bd8e7a10076527efc50"
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
