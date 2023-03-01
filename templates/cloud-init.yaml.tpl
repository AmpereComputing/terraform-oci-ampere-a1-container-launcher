#cloud-config

package_update: true
package_upgrade: true

packages:
  - tmux
  - rsync
  - git
  - curl
  - python3-pip-wheel
  - python3
  - python3-devel
  - python3-pip
  - python3-pip-wheel
  - gcc
  - gcc
  - gcc-c++
  - nodejs
  - rust
  - gettext
  - device-mapper-persistent-data
  - lvm2
  - bzip2

groups:
  - docker
system_info:
  default_user:
    groups: [docker]

runcmd:
  - pip3 install -U pip
  - dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  - dnf update -y
  - dnf install docker-ce docker-ce-cli containerd.io -y
  - curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-linux-aarch64 -o /usr/local/bin/docker-compose-linux-aarch64
  - chmod -x /usr/local/bin/docker-compose-linux-aarch64
  - ln -s /usr/local/bin/docker-compose-linux-aarch64 /usr/bin/docker-compose
  - docker-compose --version
  - pip3 install -U docker-compose
  - docker info
  - systemctl enable docker
  - systemctl start docker
  - docker info
  - docker run -d ${container}
  - echo 'OCI Ampere A1 OracleLinux Container Launcher' >> /etc/motd
