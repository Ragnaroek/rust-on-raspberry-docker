This contains a utility to help with downloading transitive dependencies through apt-get.

Usage: ./download.sh [package list]

Security warning:
In order for the signature verification to work, the raspbian keys must be copied to /etc/apt/trusted.gpg.d/, the `install-keys.sh` script will do this for you.

Alternatively, apt.conf may be modified to disable signature verification by adding these lines:
APT::Get::AllowUnauthenticated "true";
Acquire::AllowInsecureRepositories "true";
Acquire::AllowDowngradeToInsecureRepositories "true";

