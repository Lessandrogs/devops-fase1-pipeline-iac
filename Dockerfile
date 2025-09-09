FROM node:20-alpine
WORKDIR /usr/src/app

# instalar apenas deps de runtime
COPY app/package.json ./
RUN npm install --omit=dev

# copiar código
COPY app/ ./

ENV PORT=3000
EXPOSE 3000

# healthcheck simples
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD node -e "require('http').get('http://localhost:'+ (process.env.PORT||3000), r=>process.exit(r.statusCode===200?0:1)).on('error',()=>process.exit(1))"

CMD ["npm","start"]
