class Bracketlint < Formula
  desc "A linter and formatter for Django, Jinja, Liquid, Nunjucks and Twig templates"
  homepage "https://github.com/feds01/bracketlint"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feds01/bracketlint/releases/download/v0.3.0/bracketlint-aarch64-apple-darwin.tar.xz"
      sha256 "80ad723589670f6768056993a6bded9e3d3c9b29c999cb7255c564d01d50431d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feds01/bracketlint/releases/download/v0.3.0/bracketlint-x86_64-apple-darwin.tar.xz"
      sha256 "0a763108bcee09da8d50157a3d08df6186c2119eda4046002b9385520281ad6a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feds01/bracketlint/releases/download/v0.3.0/bracketlint-aarch64-unknown-linux-musl.tar.xz"
      sha256 "9e05644b7d6248bc7675278046807f3b64d1747dc5f39524d3e64fa6dd692422"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feds01/bracketlint/releases/download/v0.3.0/bracketlint-x86_64-unknown-linux-musl.tar.xz"
      sha256 "e0ab465aba507f110f92fcd8d2bb07bd3b08e4d1a9ea60d2eae257f1df1d815b"
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
      bin.install "bracketlint"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "bracketlint"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "bracketlint"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "bracketlint"
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
