# Development image for the Spelling Bee game.
# Matches the Node version pinned in .node-version and CI.
FROM docker.io/library/node:20.5.1-bookworm-slim

WORKDIR /app

# Install dependencies first so this layer is cached until
# package.json or yarn.lock change. (Yarn 1 ships with the Node image.)
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy the rest of the source (overridden by the bind mount in compose).
COPY . .

# Vite 2's dev server listens on 3000 by default.
EXPOSE 3000

# --host makes the server reachable from outside the container.
CMD ["yarn", "dev", "--host", "0.0.0.0"]
