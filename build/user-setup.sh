# Setup the cross user

# On OS X, the user needs to have uid set to 1000
# in order to access files from the shared volumes.
# https://medium.com/@brentkearney/docker-on-mac-os-x-9793ac024e94

groupadd --system cross && useradd --create-home --system --gid cross --uid 1000 cross;

# When debugging the docker image it really helps if the cross user can sudo
adduser cross sudo
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

