FROM node:22

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    file \
    && rm -rf /var/lib/apt/lists/*

# Install Linuxbrew
RUN useradd -m linuxbrew \
    && mkdir -p /home/linuxbrew/.linuxbrew \
    && chown -R linuxbrew:linuxbrew /home/linuxbrew

USER linuxbrew

RUN NONINTERACTIVE=1 /bin/bash -c \
  "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"

USER root

RUN npm install -g clawdbot@latest \
    --no-audit \
    --no-fund \
    --ignore-scripts \
    && npm cache clean --force

RUN useradd -m claw
USER claw

CMD ["bash"]
