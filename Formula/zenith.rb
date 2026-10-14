class Zenith < Formula
  desc "An architecture linter for TypeScript and JavaScript codebases"
  homepage "https://github.com/feds01/zenith"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feds01/zenith/releases/download/v0.2.0/zenith-aarch64-apple-darwin.tar.xz"
      sha256 "961d4a45b0f6c554eb6bab85f47f6aaede408a8258d2ff9e622e658722684976"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feds01/zenith/releases/download/v0.2.0/zenith-x86_64-apple-darwin.tar.xz"
      sha256 "31a49d01d682ac85f0554cd702e38c12d5676106d0164302357b5fe6b4fe0123"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feds01/zenith/releases/download/v0.2.0/zenith-aarch64-unknown-linux-musl.tar.xz"
      sha256 "2ded820a36eff1824e0ef592f5e5323263922e01e66e4d82570bced839454406"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feds01/zenith/releases/download/v0.2.0/zenith-x86_64-unknown-linux-musl.tar.xz"
      sha256 "0bf873156f9ba9fe54a0d9205c406d3902800ca460ccee9645fce21f49d49cb6"
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
