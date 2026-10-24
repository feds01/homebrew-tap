class Teamsearch < Formula
  desc "Search code bases with a CODEOWNERS file in mind"
  homepage "https://github.com/feds01/teamsearch"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/feds01/teamsearch/releases/download/v0.3.0/teamsearch-aarch64-apple-darwin.tar.xz"
      sha256 "1a8983886cffa357eeebe55258fa4d74687e7dc376d8d2607e422b2b1dd54367"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feds01/teamsearch/releases/download/v0.3.0/teamsearch-x86_64-apple-darwin.tar.xz"
      sha256 "32c7db27aa706042e59640bc440c967e1742be7cb9c601437a8bfb96f38a4d71"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/feds01/teamsearch/releases/download/v0.3.0/teamsearch-aarch64-unknown-linux-musl.tar.xz"
      sha256 "59ccd75a3ccdbdfc5cd3bc5f073105e2399276204907269c9060c2b1f690391a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/feds01/teamsearch/releases/download/v0.3.0/teamsearch-x86_64-unknown-linux-musl.tar.xz"
      sha256 "a7e08e5c25a210218a0f8cd073d952189a84bfc8821a8e99b8556a5e5212b2e6"
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
      bin.install "teamsearch"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "teamsearch"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "teamsearch"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "teamsearch"
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
