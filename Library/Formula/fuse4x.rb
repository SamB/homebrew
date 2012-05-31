require 'formula'

class Fuse4x < Formula
  homepage 'http://fuse4x.github.com'
  url 'https://github.com/fuse4x/fuse/tarball/fuse4x_0_9_1'
  md5 'e8718347579bbd3900e8243f527ea7a2'
  version "0.9.1"

  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on 'gettext'
  depends_on 'fuse4x-kext'

  def install
    system "autoreconf", "--force", "--install"

    # force 64bit inodes on 10.5. On 10.6+ this is no-op.
    ENV.append_to_cflags "-D_DARWIN_USE_64_BIT_INODE"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-static",
                          "--disable-debug",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
