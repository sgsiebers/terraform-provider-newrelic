ARG TF_VERSION=0.11.14

FROM golang:alpine as build
LABEL maintainer="Scott Siebers <scott.siebers@cerner.com>"

RUN apk add --update git bash make

# Clone and buid custom newrelic terraform provider
WORKDIR $GOPATH/src/github.com/terraform-providers
RUN git clone https://github.com/sgsiebers/terraform-provider-newrelic.git
WORKDIR $GOPATH/src/github.com/terraform-providers/terraform-provider-newrelic
RUN git checkout synthetics
RUN make



FROM hashicorp/terraform:$TF_VERSION as final

RUN apk add --update bash


RUN mkdir -p ~/.terraform.d/plugins
COPY --from=build ["/go/bin/terraform-provider-newrelic", " ~/.terraform.d/plugins/"]
