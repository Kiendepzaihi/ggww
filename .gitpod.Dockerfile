FROM gitpod/workspace-full

# Cài đặt Docker và các công cụ cần thiết
RUN sudo apt-get update && \
    sudo apt-get install -y docker.io curl unzip

# Cài đặt Pterodactyl Panel
RUN curl -sSL https://get.docker.com/ | sh
