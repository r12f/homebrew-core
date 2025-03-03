class Soapysdr < Formula
  desc "Vendor and platform neutral SDR support library"
  homepage "https://github.com/pothosware/SoapySDR/wiki"
  url "https://github.com/pothosware/SoapySDR/archive/soapy-sdr-0.8.1.tar.gz"
  sha256 "a508083875ed75d1090c24f88abef9895ad65f0f1b54e96d74094478f0c400e6"
  license "BSL-1.0"
  head "https://github.com/pothosware/SoapySDR.git"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "a6fdf172d9d0bc7338b9792211cd9b5f945656908b1d642b987b84d68e1c7704"
    sha256 cellar: :any, big_sur:       "43f22365e9bc1ecb07cc3c4ee22c198f25c3465ae5cf72f2681223aee30f357b"
    sha256 cellar: :any, catalina:      "befa2166bf6dd66c45cb2aa00a439d480c227972a5a17242b5a11f50ffdbc25e"
    sha256 cellar: :any, mojave:        "73f853d0e804e3b3253bd0e23a2387254d8a178850f989f9a7c7cb87e6bafc7c"
  end

  depends_on "cmake" => :build
  depends_on "swig" => :build
  depends_on "python@3.9"

  def install
    args = std_cmake_args + %W[
      -DENABLE_PYTHON=OFF
      -DENABLE_PYTHON3=ON
      -DSOAPY_SDR_ROOT=#{HOMEBREW_PREFIX}
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
    args << "-DSOAPY_SDR_EXTVER=release" unless build.head?

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    assert_match "Loading modules... done", shell_output("#{bin}/SoapySDRUtil --check=null")
  end
end
