###########################
# Builder image (stage 1) #
###########################
FROM golang:1.11-alpine as builder

ARG depVersion=0.5.0
ARG executableName
ARG repoName=sandvikcode
ARG projectName=${executableName}

RUN apk add --no-cache alpine-sdk zip

# Install golang dependency manager
RUN curl -fsSL -o /usr/local/bin/dep https://github.com/golang/dep/releases/download/v${depVersion}/dep-linux-amd64 \
&& chmod +x /usr/local/bin/dep

WORKDIR ${GOPATH}/src/github.com/${repoName}/${projectName}

# Get the source files in
COPY . .

# Get dependencies and then lint
RUN [ "make", "vendor", "lint", "test" ]
