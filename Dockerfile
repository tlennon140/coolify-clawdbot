FROM node:22

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    file \
    && rm -rf /var/lib/apt/lists/*

# Create linuxbrew user
RUN useradd -m linuxbrew

# Install Homebrew as linuxbrew
USER linuxbrew
RUN NONINTERACTIVE=1 /bin/bash -c \
  "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"

# Back to root for npm globals
USER root
RUN npm install -g undici \
    && npm install -g clawdbot@latest \
       --no-audit \
       --no-fund \
       --ignore-scripts \
    && npm cache clean --force

# Drop back to linuxbrew for runtime
USER linuxbrew

CMD ["bash"]
