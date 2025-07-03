# 1. Imagem Base
# Usando uma imagem 'slim' que oferece um bom equilíbrio entre tamanho e compatibilidade.
FROM python:3.11-slim

# 2. Definir Variáveis de Ambiente
# Evita que o Python grave arquivos .pyc e armazene saídas em buffer.
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 3. Definir o Diretório de Trabalho
WORKDIR /app

# 4. Instalar Dependências
# Copia primeiro o arquivo de dependências para aproveitar o cache do Docker.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o Código da Aplicação
COPY . .

# 6. Expor a Porta
# A porta em que a aplicação será executada.
EXPOSE 8000

# 7. Executar a Aplicação
# Comando para iniciar o app com uvicorn, acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]