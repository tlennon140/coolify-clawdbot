# Use official Node 22 image
FROM node:22

# Install pnpm
RUN corepack enable && npm install -g pnpm

# Create app directory
WORKDIR /app

# Install Clawdbot CLI globally
RUN pnpm add -g clawdbot@latest

# Ensure Clawdbot bin is on PATH (pnpm global bin)
ENV PATH="$PATH:$(pnpm bin -g)"

# Default command is bash so container doesn't exit
CMD ["bash"]
