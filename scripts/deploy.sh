@echo off
setlocal enabledelayedexpansion

set OWNER=%OWNER%
if "%OWNER%"=="" set OWNER=Lessandrogs
set IMAGE=ghcr.io/%OWNER%/devops-fase1-pipeline-iac:latest

echo [deploy] docker pull %IMAGE%
docker pull %IMAGE%

echo [deploy] docker compose up -d
docker compose up -d

echo [deploy] OK. Teste em http://SEU_SERVIDOR:3000
