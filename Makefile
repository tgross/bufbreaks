.PHONY: test
test: build
	./bin/old write
	./bin/new read

.PHONY: build
build: protos bin/old bin/new

bin/old:
	go build -trimpath -tags old -o bin/old .

bin/new:
	go build -trimpath -tags new -o bin/new .

.PHONY: protos
protos: install structs.old.pb.go structs.new.pb.go

structs.new.pb.go:
	./bin/buf-0.41.0 generate
	echo '// +build new,!old' > structs.new.pb.go
	echo >> structs.new.pb.go
	cat structs.pb.go >> structs.new.pb.go
	rm structs.pb.go

structs.old.pb.go:
	./bin/buf-0.36.0 generate
	echo '// +build old,!new' > structs.old.pb.go
	echo >> structs.old.pb.go
	cat structs.pb.go >> structs.old.pb.go
	rm structs.pb.go

.PHONY: install
install: bin/buf-0.36.0 bin/buf-0.41.0

bin/buf-0.36.0:
	GOBIN="$(shell pwd)/bin" go install github.com/bufbuild/buf/cmd/buf@v0.36.0
	mv ./bin/buf ./bin/buf-0.36.0

bin/buf-0.41.0:
	GOBIN="$(shell pwd)/bin" go install github.com/bufbuild/buf/cmd/buf@v0.41.0
	mv ./bin/buf ./bin/buf-0.41.0

.PHONY: clean
clean:
	rm -f *.pb.go
	rm -f example.bin

.PHONY: nuke
nuke: clean
	rm -rf bin
