FROM node:20

# Instalar dependências necessárias e o Google Chrome
RUN apt-get update && apt-get install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Configurar diretório de trabalho
WORKDIR /app

# Copiar os arquivos do projeto
COPY . .

# Instalar dependências do projeto
RUN npm install

# Definir a variável de ambiente para o Puppeteer
ENV PUPPETEER_EXECUTABLE_PATH="/usr/bin/google-chrome-stable"

# Expor a porta, se necessário
EXPOSE 3000

# Comando para rodar a aplicação
CMD ["node", "index.js"]
