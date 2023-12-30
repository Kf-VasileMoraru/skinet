#FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
#WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY *.sln .
COPY API/*.csproj ./API/
COPY Core/*.csproj ./Core/
COPY Infrastructure/*.csproj ./Infrastructure/
RUN dotnet restore *.sln
COPY . .
#ENTRYPOINT ["dotnet", "run", "--project", "API/API.csproj"]



FROM build AS publish
#RUN dotnet publish *.sln -c Debug -o /app/publish /p:UseAppHost=false
RUN dotnet build *.sln -c Debug -o /app/publish /p:UseAppHost=false
WORKDIR /app/publish


#FROM base AS final
#WORKDIR /app
#COPY  --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "API.dll"]


