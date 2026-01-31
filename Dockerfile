FROM node:22-bookworm-slim

WORKDIR /app

# Install Clawdbot CLI safely in CI
RUN npm install -g clawdbot@latest \
    --no-audit \
    --no-fund \
    --ignore-scripts \
    && npm cache clean --force

# Create non-root user
RUN useradd -m claw

USER claw

ENV PATH="/usr/local/bin:$PATH"

CMD ["bash"]
