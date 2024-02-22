FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY *.sln .
COPY API/*.csproj ./API/
COPY Core/*.csproj ./Core/
COPY Infrastructure/*.csproj ./Infrastructure/
RUN dotnet restore *.sln
COPY . .
#CMD ["dotnet", "run", "--project", "API/API.csproj", "--configuration", "Debug"]

FROM build AS publish
RUN dotnet publish *.sln -c Debug --property:PublishDir=/app/publish /p:UseAppHost=false
WORKDIR /app/publish

FROM base AS final
WORKDIR /app
COPY  --from=publish /app/publish .
CMD ["dotnet", "API.dll"]


#FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
#WORKDIR /source
#
## copy csproj and restore as distinct layers
#COPY StarshipTraveler.ServerSide/*.csproj ./StarshipTraveler.ServerSide/
#COPY StarshipTraveler.Model/*.csproj ./StarshipTraveler.Model/
#COPY StarshipTraveler.Components/*.csproj ./StarshipTraveler.Components/
#RUN dotnet restore StarshipTraveler.ServerSide/StarshipTraveler.ServerSide.csproj
#
## copy everything else and build app
#COPY StarshipTraveler.ServerSide/. StarshipTraveler.ServerSide/.
#COPY StarshipTraveler.Model/. StarshipTraveler.Model/.
#COPY StarshipTraveler.Components/. StarshipTraveler.Components/.
#RUN dotnet publish StarshipTraveler.ServerSide -c release -o /app --no-restore
#
## final stage/image
#FROM mcr.microsoft.com/dotnet/aspnet:7.0
#WORKDIR /app
#COPY --from=build /app ./
#ENTRYPOINT ["dotnet", "StarshipTraveler.ServerSide.dll"]
