class Zenith < Formula
  desc "An architecture linter for monorepos"
  homepage "https://github.com/feds01/zenith"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feds01/zenith/releases/download/v0.7.0/zenith-aarch64-apple-darwin.tar.xz"
      sha256 "52fcab94c11fa690f3aa7170e27ce8ca23e6c046e409f319e049eb0f17ea0d03"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feds01/zenith/releases/download/v0.7.0/zenith-x86_64-apple-darwin.tar.xz"
      sha256 "1f8efa840f92a752dad480bebd4b70fe359af2e546b31d46f25741b9492fdbe5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feds01/zenith/releases/download/v0.7.0/zenith-aarch64-unknown-linux-musl.tar.xz"
      sha256 "b2b476f81136ceca4dab395eaba489734439e1e6989d7f7b2da8b1f66675b2cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feds01/zenith/releases/download/v0.7.0/zenith-x86_64-unknown-linux-musl.tar.xz"
      sha256 "34f0dd4014c85295ef41b6302576d8497d3b479935bbeb4cc343519fa9a9f243"
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
