This contains a utility to help with downloading transitive dependencies through apt-get.

Usage: ./download.sh [package list]

Security warning:
In order for the signature verification to work, you must copy trusted.gpg.d/raspbian.asc to /etc/apt/trusted.gpg.d/

Alternatively, apt.conf can be modified to disable signature verification by adding these lines:
APT::Get::AllowUnauthenticated "true";
Acquire::AllowInsecureRepositories "true";
Acquire::AllowDowngradeToInsecureRepositories "true";

