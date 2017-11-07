FROM avezila/go

# install protobuf
RUN mkdir -p /tmp/protoc && \
    curl -L https://github.com/google/protobuf/releases/download/v3.4.0/protoc-3.4.0-linux-x86_64.zip > /tmp/protoc/protoc.zip && \
    cd /tmp/protoc && \
    unzip protoc.zip && \
    cp /tmp/protoc/bin/protoc /usr/local/bin && \
    chmod go+rx /usr/local/bin/protoc && \
    cd /tmp && \
    rm -r /tmp/protoc

# Get the source from GitHub
RUN go get google.golang.org/grpc
# Install protoc-gen-go
RUN go get github.com/golang/protobuf/protoc-gen-go
RUN mkdir -p /grpc
RUN dnf install nodejs -y
WORKDIR /grpc
CMD mkdir -p generated && /usr/local/bin/protoc --go_out=plugins=grpc:./generated --java_out=./generated --js_out=library=grpc,binary:./generated `find . | grep .*\.proto$`
