FROM mcr.microsoft.com/dotnet/core/sdk:3.1

WORKDIR /opt

ENV PATH="/opt/bin:${PATH}"

# Download and compile DepotDownloader
RUN git clone --depth 1 --branch DepotDownloader_2.3.6 https://github.com/SteamRE/DepotDownloader.git build/ \
  && dotnet build build/DepotDownloader.sln \
  && mkdir DepotDownloader \
  && mv build/DepotDownloader/bin/Debug/netcoreapp2.0/* ./DepotDownloader \
  && rm -rf build \
  && mkdir /steam

COPY scripts/download /opt/bin/download
