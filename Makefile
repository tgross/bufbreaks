.PHONY: test
test: build
	./bin/old write
	./bin/new read

.PHONY: build
build: protos bin/old bin/new

bin/old: *.go
	go build -trimpath -tags old -o bin/old .

bin/new: *.go
	go build -trimpath -tags new -o bin/new .

.PHONY: protos
protos: install structs.old.pb.go structs.new.pb.go

structs.new.pb.go: structs.proto
	PATH="$(shell pwd)/bin:$$PATH" ./bin/buf-0.41.0 generate --template buf.gen.new.yaml
	echo '// +build new,!old' > structs.new.pb.go
	echo >> structs.new.pb.go
	cat structs.pb.go >> structs.new.pb.go
	rm structs.pb.go

structs.old.pb.go: structs.proto
	PATH="$(shell pwd)/bin:$$PATH" ./bin/buf-0.36.0 generate --template buf.gen.old.yaml
	echo '// +build old,!new' > structs.old.pb.go
	echo >> structs.old.pb.go
	cat structs.pb.go >> structs.old.pb.go
	rm structs.pb.go

.PHONY: install
install: bin/buf-0.36.0 bin/buf-0.41.0 bin/protoc-gen-go-old bin/protoc-gen-go-new

bin/buf-0.36.0:
	GOBIN="$(shell pwd)/bin" go install github.com/bufbuild/buf/cmd/buf@v0.36.0
	mv ./bin/buf ./bin/buf-0.36.0

bin/buf-0.41.0:
	GOBIN="$(shell pwd)/bin" go install github.com/bufbuild/buf/cmd/buf@v0.41.0
	mv ./bin/buf ./bin/buf-0.41.0

bin/protoc-gen-go-old:
	GOBIN="$(shell pwd)/bin" go install github.com/golang/protobuf/protoc-gen-go@v1.3.4
	mv ./bin/protoc-gen-go ./bin/protoc-gen-go-old

bin/protoc-gen-go-new:
	GOBIN="$(shell pwd)/bin" go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.26.0
	mv ./bin/protoc-gen-go ./bin/protoc-gen-go-new

.PHONY: clean
clean:
	rm -f *.pb.go
	rm -f example.bin

.PHONY: nuke
nuke: clean
	rm -rf bin
