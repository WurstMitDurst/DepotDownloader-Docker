# Build image
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as build

RUN git clone --depth 1 --branch DepotDownloader_2.3.6 https://github.com/SteamRE/DepotDownloader.git build/ \
  && dotnet publish -c release -o /app -r linux-x64 build/DepotDownloader.sln


# Final image
# DepotDownlaoder targets dotnetcore2.0, which requires
# OpenSSL 1.0. This is not available in buster and newer,
# so we are stuck to Debian stretch.
FROM debian:stretch-slim

ENV PATH="/opt/bin:${PATH}"

# Install curl, when build target was dotnetcore2.0
# Install wget, when build target was dotnetcore3.0 and higher
RUN apt-get update && apt-get install -y curl libicu57 libssl1.0.2 libunwind8 \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /opt/DepotDownloader \
  && mkdir /steam

COPY --from=build /app/* /opt/DepotDownloader/

COPY scripts/download /opt/bin/download
