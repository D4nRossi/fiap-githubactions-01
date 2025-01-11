# Etapa 1: Build da aplica��o
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /App

# Copiar tudo do contexto atual para dentro do container
COPY . . 

# Restaurar pacotes NuGet
RUN dotnet restore

# Build e publica��o do projeto
RUN dotnet publish -c Release -o out

# Etapa 2: Configurar o runtime
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /App

# Copiar a sa�da do build para o runtime
COPY --from=build-env /App/out .

# Ponto de entrada
ENTRYPOINT ["dotnet", "DockerApp.dll"]
