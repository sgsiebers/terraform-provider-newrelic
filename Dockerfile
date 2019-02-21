FROM hashicorp/terraform:full
LABEL maintainer="Scott Siebers <scott.siebers@cerner.com>"

RUN apk add --update make


# Clone and install custom newrelic terraform provider
WORKDIR $GOPATH/src/github.com/terraform-providers
RUN git clone https://github.com/sgsiebers/terraform-provider-newrelic.git
WORKDIR $GOPATH/src/github.com/terraform-providers/terraform-provider-newrelic
RUN git checkout synthetics
RUN make
RUN mkdir -p ~/.terraform.d/plugins
RUN mv $GOPATH/bin/terraform-provider-newrelic ~/.terraform.d/plugins/
WORKDIR $GOPATH
