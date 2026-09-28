FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

WORKDIR /app
ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy UV_NO_DEV=1

COPY pyproject.toml uv.lock README.md ./
RUN uv sync --locked --no-install-project

COPY src ./src
RUN uv sync --locked

ENV MTG_MCP_TRANSPORT=http MTG_MCP_HTTP_HOST=0.0.0.0
CMD ["sh", "-c", "MTG_MCP_HTTP_PORT=${PORT:-8000} exec /app/.venv/bin/mtg-mcp-server"]
