flowchart LR
  A[Push/PR] --> B[Actions: Lint]
  B --> C[Testes Node 18/20]
  C --> D[Build]
  D --> E[Docker Build + Push (GHCR)]
  E --> F[Deploy (docker compose)]
  F --> G[App rodando em container]
