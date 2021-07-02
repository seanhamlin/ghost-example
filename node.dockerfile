FROM ghost:4-alpine as builder

FROM uselagoon/node-14:latest

ENV GHOST_INSTALL="/var/lib/ghost" \
  GHOST_CONTENT="/var/lib/ghost/content" \
  GHOST_THEMES="/var/lib/ghost/content/themes" \
  GHOST_APPS="/var/lib/ghost/content/apps" \
  GHOST_DATA="/var/lib/ghost/content/data" \
  GHOST_IMAGES="/var/lib/ghost/content/images" \
  GHOST_SETTINGS="/var/lib/ghost/content/settings" \
  NODE_ENV="production" \
  GHOST_CLI_VERSION="latest" \
  HOME="/home/node"

COPY --from=builder --chown=node:node "${GHOST_INSTALL}" "${GHOST_INSTALL}"

RUN set -eux; \
  npm install -g "ghost-cli@$GHOST_CLI_VERSION"; \
  npm cache clean --force

RUN apk add --no-cache 'su-exec>=0.2'
RUN set -eux; \
  mkdir -p "$GHOST_THEMES" && chown node:node "$GHOST_THEMES"; \
  mkdir -p "$GHOST_APPS" && chown node:node "$GHOST_APPS"; \
  mkdir -p "$GHOST_DATA" && chown node:node "$GHOST_DATA"; \
  mkdir -p "$GHOST_IMAGES" && chown node:node "$GHOST_IMAGES"; \
  mkdir -p "$GHOST_SETTINGS" && chown node:node "$GHOST_SETTINGS"; \
  cd $GHOST_INSTALL; \
  find $GHOST_INSTALL -type d -exec chmod 00775 {} \; ; \
  cp -R ${GHOST_CONTENT}.orig/themes/* $GHOST_THEMES && chown node:node "$GHOST_THEMES"; \
  su-exec node ghost version; \
  su-exec node ghost config --port 3000; \
  su-exec node ghost config --url "http://localhost:3000"; \
  su-exec node ghost config --log "stdout"; \
  su-exec node ghost config set server.host 0.0.0.0;

WORKDIR $GHOST_INSTALL
EXPOSE 3000

# Run as the node user (as ghost does not like running as root).
USER 1000

# Database environment variables shim.
COPY entrypoints/60-database.sh /lagoon/entrypoints/

# @TODO wait for the database to start.
CMD ["node", "current/index.js"]
