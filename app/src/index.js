/* eslint-env node */

const http = require("http");

function sum(a, b) {
  return a + b;
}

function startServer() {
  const port = process.env.PORT || 3000;
  const server = http.createServer((req, res) => {
    res.writeHead(200, { "Content-Type": "text/plain" });
    res.end("OK - DevOps Fase 2\n");
  });
  server.listen(port, () => console.log(`Server on http://localhost:${port}`));
  return server;
}

// Inicia servidor só quando for chamado diretamente (npm start)
if (require.main === module) {
  startServer();
}

module.exports = { sum, startServer };
