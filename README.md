```docker
sudo service docker status
```

Verificar o status do docker

# **DOCKER IMAGES**

## INFORMAÇÕES SOBRE A IMAGEM

```bash
docker inspect nginx:latest
```

Serve para **exibir informações detalhadas** sobre a imagem **nginx:latest** em formato JSON.

## LISTAR IMAGES

```docker
docker images
```

Lista todas as images.

## REMOVER IMAGE

```docker
docker rmi "NAME"

#EXEMPLO
docker rmi 3v283
```

Remove a image.

## REMOVER TODAS AS  IMAGENS

```bash
docker rmi $(docker images -q)
```

**Remove todas as imagens do Docker** que estão no sistema. 

---

**Explicação das flags:**

- `docker images -q` → Lista **apenas os IDs das imagens**, sem detalhes extras.
- `$(...)` → Executa o comando dentro dos parênteses e usa sua saída como argumento.
- `docker rmi` → **Remove** as imagens fornecidas pelo comando anterior.

## VER COMO A IMAGES FOI CONTRUIDA

```bash
docker history dockersamples/static-site:latest

```

**Explicação:**

- Esse comando **exibe o histórico de camadas (`layers`)** da imagem `dockersamples/static-site:latest`.
- Ele mostra **como a imagem foi construída**, incluindo cada instrução do Dockerfile usada para criá-la.

## CRIAR IMAGEN DOCKER

```bash
docker commit jovial_chatterjee ubuntu-potencializado
```

**📌 O que ele faz?**

Esse comando **cria uma nova imagem Docker** baseada no estado atual do contêiner `jovial_chatterjee` e a nomeia como `ubuntu-potencializado`.

**Explicação das flags:**

- `docker commit` → **Cria uma nova imagem** a partir de um contêiner existente.
- `jovial_chatterjee` → Nome ou ID do contêiner que será salvo como uma imagem.
- `ubuntu-potencializado` → Nome da nova imagem gerada.

---

# DOCKER CONTEINER

## LISTAR CONTAINER

```docker
docker ps

#variante
docker container ls 
```

Lista apenas os contêineres em execução

```docker
docker ps -a

#variante
docker container ls -a
```

- **`-a`** lista **todos os contêineres** no seu sistema

## REMOVER CONTEINER

```docker
docker rm "ID" OU "NAME"

#EXEMPLO
docker rm 3v283
```

Remove o container

### REMOVER TODOS OS CONTAINERS

```docker
docker container prune
```

**remove todos os contêineres parados** do Docker.

### FORÇAR REMOÇÃO MESMO O CONTAINER RODANDO

```docker
docker rm -f 49759caala69
```

Explicação das flags:

- `docker rm` → **Remove um contêiner** do Docker.
- `f` (**force**) → **Força a remoção**, mesmo se o contêiner estiver rodando.
- `49759caala69` → **ID** ou **nome** do contêiner a ser removido.

## RODAR CONTAINER INTERATIVO

```docker
docker run -i -t ubuntu
```

serve para **rodar um contêiner interativo** baseado na imagem `ubuntu`.

Explicação das flags:

- `i` (**interactive**) → Mantém o STDIN aberto para entrada do usuário.
- `t` (**tty**) → Aloca um terminal para interação.

Na prática, isso inicia um contêiner e abre um **terminal dentro dele**, permitindo que você interaja com o sistema Ubuntu.

## RENOMEAR CONTAINER

```docker
docker run --name meu-ubuntu-it ubuntu
```

irá iniciar um **novo contêiner** baseado na imagem `ubuntu` e dar a ele o nome `meu-ubuntu-it`.

## INICIAR CONTEINER EM SEGUNDO PLANO

```docker
docker run -di ubuntu

```

irá iniciar um **contêiner em segundo plano (modo daemon)** usando a imagem `ubuntu`.

Explicação das flags:

- `d` (**detached**) → Executa o contêiner em **background** (modo daemon).
- `i` (**interactive**) → Mantém o **STDIN** aberto para entrada de dados.
- `ubuntu` → Usa a imagem do Ubuntu.

## EXECUTAR COMANDO DENTRO DE CONTEINER EM EXECUÇÃO

```bash
docker exec 2daled56db51 echo "GAB"
```

irá executar o comando `echo "GAB"` dentro do contêiner **já em execução** com o ID `2daled56db51`.

**Explicação:**

- `docker exec` → Executa um comando dentro de um contêiner que já está rodando.
- `2daled56db51` → ID do contêiner onde o comando será executado.
- `echo "GAB"` → Exibe "GAB" no terminal.

## PARAR CONTAINER

```bash
docker stop 2dat
```

- irá tentar **parar** o contêiner cujo ID começa com `2dat`.

### PARA COTEINER INSTANTANEAMENTE

```bash
docker stop -t 0 meu-container
```

Isso interrompe `meu-container` **instantaneamente**, sem esperar pelo encerramento normal.

Explicação das flags:

- `docker stop` → **Envia um sinal** para parar um contêiner em execução.
- `t 10` (**timeout**) → Aguarda **10 segundos** antes de forçar a parada do contêiner.
- `meu-container` → Nome ou **ID** do contêiner que será parado.

## INICIAR CONTAINER PARADO

```bash
docker start -ai meu-ubuntu
```

irá **iniciar** um contêiner parado chamado `meu-ubuntu` e **anexar o terminal a ele**, permitindo interação.

Explicação das flags:

- `docker start` → Inicia um contêiner que já foi criado.
- `a` (**attach**) → Conecta o terminal à saída do contêiner.
- `i` (**interactive**) → Mantém a entrada aberta para interação.
- `meu-ubuntu` → Nome do contêiner a ser iniciado.

---

# CRIANDO O DOCKERFILE

Criar um documento **.dockerfile**

```docker
FROM ubuntu:22.04

# Atualiza o sistema e instala dependências corretamente
RUN apt-get update && \
    apt-get install -y python3.11 python3.11-dev python3-pip  # Corrigido "pt-get" para "apt-get"

WORKDIR /app

# Copia os arquivos do projeto
COPY . .

# Instala as dependências do Python
RUN pip3 install --no-cache-dir -r requirements.txt

# Define a porta exposta pelo container
EXPOSE 8080

# Corrige erros de digitação e espaços nos valores das variáveis de ambiente
ENV LOGOMARCA="https://cdn.discordapp.com/attachments/1074800287853858995/11107820890032709643/logomarca-azul-1800x235.png"
ENV FOTO="https://cdn.discordapp.com/attachments/1874800287853858997/1113253295033696337/image.png"
ENV NOME="Gab"
ENV IDADE="27"
ENV EMAIL="lucas@techeduca.com.br"  # Corrigido "EMATL" para "EMAIL"
ENV PROFISSAO="Instrutor"
ENV SITE="www.techeduca.com.br"

# Define o comando padrão para executar o app
CMD ["python3", "app.py"]
```

## 🛠️ **Quebrando o Dockerfile em partes:**

### **1️⃣ Escolhendo a imagem base**

```docker
FROM ubuntu:22.04
```

- Usa a **imagem oficial do Ubuntu 22.04** como base.
- Isso significa que o container começará como um sistema operacional Ubuntu minimalista.

---

### **2️⃣ Instalando dependências**

```docker
RUN apt-get update && \
    apt-get install -y python3.11 python3.11-dev python3-pip
```

- **`apt-get update`** → Atualiza a lista de pacotes disponíveis.
- **`apt-get install -y`** → Instala:
    - `python3.11` → A versão 3.11 do Python.
    - `python3.11-dev` → Pacotes de desenvolvimento para Python 3.11.
    - `python3-pip` → Gerenciador de pacotes do Python (pip).

---

### **3️⃣ Definindo o diretório de trabalho**

```docker
WORKDIR /app
```

- Define `/app` como o diretório onde os comandos serão executados dentro do container.
- Isso evita que precisemos navegar até o diretório manualmente.

---

### **4️⃣ Copiando arquivos do projeto**

```docker
COPY . .
```

- Copia **todos os arquivos** do diretório atual (onde está o `Dockerfile`) para dentro do container, no diretório `/app`.

---

### **5️⃣ Instalando dependências do projeto**

```docker
RUN pip3 install --no-cache-dir -r requirements.txt
```

- Usa o **pip3** para instalar os pacotes listados no `requirements.txt` do projeto.
- A flag `-no-cache-dir` evita armazenar cache, reduzindo o tamanho da imagem.

---

### **6️⃣ Expondo porta**

- Indica que o **container escutará na porta 8080**.
- Isso **não** mapeia a porta automaticamente para o host, apenas indica que a aplicação a usará.

---

### **7️⃣ Definindo variáveis de ambiente**

```docker
ENV LOGOMARCA="https://cdn.discordapp.com/attachments/1074800287853858995/11107820890032709643/logomarca-azul-1800x235.png"
ENV FOTO="https://cdn.discordapp.com/attachments/1874800287853858997/1113253295033696337/image.png"
ENV NOME="Gab"
ENV IDADE="27"
ENV EMAIL="lucas@techeduca.com.br"
ENV PROFISSAO="Instrutor"
ENV SITE="www.techeduca.com.br"
```

- Define **valores padrão** para variáveis de ambiente dentro do container.
- Essas variáveis podem ser usadas pelo código Python com `os.environ.get("NOME")`, por exemplo.

---

### **8️⃣ Definindo o comando de inicialização**

```docker
CMD ["python3", "app.py"]
```

- Esse comando **será executado automaticamente** quando o container for iniciado.
- Ele roda a aplicação Python (`app.py`).

## CONSTRUIR IMAGE

```bash
docker build -t minha-app-python:v1 .
```

**Constrói uma imagem Docker a partir do `Dockerfile` no diretório atual (`.`) e a nomeia `minha-app-python:v1`**.

---

📌 **Explicação detalhada**

- **`docker build`** → Inicia o processo de construção da imagem Docker.
- **`t minha-app-python:v1`** → Define um nome (`minha-app-python`) e uma **tag** (`v1`) para a imagem.
    - A tag (`v1`) permite identificar a versão da imagem.
- **`.` (ponto)** → Indica que o `Dockerfile` está no diretório atual.
