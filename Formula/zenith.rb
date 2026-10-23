class Zenith < Formula
  desc "An architecture linter for monorepos"
  homepage "https://github.com/feds01/zenith"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feds01/zenith/releases/download/v0.5.0/zenith-aarch64-apple-darwin.tar.xz"
      sha256 "448e664350b5f375dca4b659b3e20b62451427b41f9cbb30d7cf10c956d0fcb5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feds01/zenith/releases/download/v0.5.0/zenith-x86_64-apple-darwin.tar.xz"
      sha256 "d22e67d92b754059faa59f0166b13a4ef005d7995287229486d687c7d2b84a08"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feds01/zenith/releases/download/v0.5.0/zenith-aarch64-unknown-linux-musl.tar.xz"
      sha256 "53627a4dfa27223406e20055f44f648c9a0b9ea2945a87d8732739d74171822e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feds01/zenith/releases/download/v0.5.0/zenith-x86_64-unknown-linux-musl.tar.xz"
      sha256 "41e981b17e8d95907d5f0dde11c4190452186e261183bb55e202a8ae8f4a8d22"
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
