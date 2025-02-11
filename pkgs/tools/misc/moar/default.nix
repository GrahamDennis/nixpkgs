{ lib, buildGoModule, fetchFromGitHub, installShellFiles }:

buildGoModule rec {
  pname = "moar";
  version = "1.15.0";

  src = fetchFromGitHub {
    owner = "walles";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-FhP77kp3OOlUTIu96NTRjzF+x5K3MGKIMeQP4mMhy/I=";
  };

  vendorHash = "sha256-aFCv6VxHD1bOLhCHXhy4ubik8Z9uvU6AeqcMqIZI2Oo=";

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installManPage ./moar.1
  '';

  ldflags = [
    "-s" "-w"
    "-X" "main.versionString=v${version}"
  ];

  meta = with lib; {
    description = "Nice-to-use pager for humans";
    homepage = "https://github.com/walles/moar";
    license = licenses.bsd2WithViews;
    maintainers = with maintainers; [ foo-dogsquared ];
  };
}
