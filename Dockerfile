FROM node:22-bookworm-slim

# Enable corepack (for future use if needed)
RUN corepack enable

# Create non-root user
RUN useradd -m claw

WORKDIR /app

# Install Clawdbot globally
RUN npm install -g clawdbot@latest --ignore-scripts \
    && npm cache clean --force

# Switch to non-root user
USER claw

# Ensure global npm bin is on PATH
ENV PATH="/usr/local/bin:$PATH"

CMD ["bash"]
