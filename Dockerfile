# Dockerfile
FROM elixir:1.15

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
  build-essential \
  postgresql-client \
  nodejs \
  npm

# Cria diretório da aplicação
WORKDIR /app

# Copia arquivos mix.exs e mix.lock
COPY mix.exs mix.lock ./

# Instala as dependências do Elixir
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get

# Copia o restante do projeto
COPY . .

# Compila o projeto
RUN mix deps.compile

# Porta padrão do Phoenix
EXPOSE 4000

# Comando padrão ao iniciar o container
CMD ["mix", "phx.server"]
