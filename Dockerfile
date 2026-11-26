FROM diygod/rsshub:chromium-bundled

USER root

RUN mkdir -p /app/cookiecloud \
    && curl -fsSL https://github.com/sgpublic/rsshub-cookiecloud/archive/refs/heads/master.tar.gz \
       | tar -xz --strip-components=1 -C /app/cookiecloud \
    && node -e "import('crypto-js').catch(() => process.exit(1))" \
       || (cd /app/cookiecloud && npm init -y && npm install --omit=dev crypto-js) \
    && chmod -R a+rwX /app/dist /app/cookiecloud

WORKDIR /app

CMD ["node", "/app/cookiecloud/index.js"]
