FROM armhf/alpine:3.5
ENTRYPOINT ["/bin/registrator"]

COPY . /go/src/github.com/gliderlabs/registrator
RUN apk add --no-cache -t build-deps build-base go git mercurial \
	&& cd /go/src/github.com/gliderlabs/registrator \
	&& export GOPATH=/go \
	# https://github.com/niemeyer/gopkg/issues/50#issuecomment-273299592
	&& git config --global http.https://gopkg.in.followRedirects true \
	&& go get \
	&& go build -ldflags "-X main.Version=$(cat VERSION)" -o /bin/registrator \
	&& rm -rf /go \
	&& apk del --purge build-deps \
	&& rm -rf /var/cache/apk/*
