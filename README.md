# bufbreaks

_Demonstration of some breaking changes in Nomad's protobuf tooling_


```
$ make test
go build -trimpath -tags old -o bin/old .
go build -trimpath -tags new -o bin/new .
./bin/old write
./bin/new read
panic: protobuf tag not enough fields in Timestamp.state:

goroutine 1 [running]:
github.com/golang/protobuf/proto.(*unmarshalInfo).computeUnmarshalInfo(0xc0000ce460)
        github.com/golang/protobuf@v1.5.0/proto/table_unmarshal.go:332 +0x1777
github.com/golang/protobuf/proto.(*unmarshalInfo).unmarshal(0xc0000ce460, 0xc0000b2240, 0xc0000ee00d, 0xb, 0x1f3, 0xc0000ee004, 0x7)
        github.com/golang/protobuf@v1.5.0/proto/table_unmarshal.go:136 +0xf45
github.com/golang/protobuf/proto.makeUnmarshalMessagePtr.func1(0xc0000ee00d, 0xb, 0x1f4, 0xc0000b2210, 0x2, 0xc0000ee00b, 0xd, 0x1f5, 0x0, 0x0)
        github.com/golang/protobuf@v1.5.0/proto/table_unmarshal.go:1646 +0x12b
github.com/golang/protobuf/proto.(*unmarshalInfo).unmarshal(0xc0000ce3c0, 0xc0000b2200, 0xc0000ee002, 0x16, 0x1fe, 0x0, 0x12aa320)
        github.com/golang/protobuf@v1.5.0/proto/table_unmarshal.go:173 +0x88e
github.com/golang/protobuf/proto.makeUnmarshalMessagePtr.func1(0xc0000ee002, 0x16, 0x1ff, 0xc00009c870, 0x2, 0xc0000c5d68, 0x756ea1d8d90c87, 0x203000, 0x203000, 0x203000)
        github.com/golang/protobuf@v1.5.0/proto/table_unmarshal.go:1646 +0x12b
github.com/golang/protobuf/proto.(*unmarshalInfo).unmarshal(0xc0000ce320, 0xc00009c870, 0xc0000ee000, 0x18, 0x200, 0x100a06c, 0x141c920)
        github.com/golang/protobuf@v1.5.0/proto/table_unmarshal.go:173 +0x88e
github.com/golang/protobuf/proto.(*InternalMessageInfo).Unmarshal(0x13eea20, 0x12a7108, 0xc00009c870, 0xc0000ee000, 0x18, 0x200, 0x4a31901, 0x4a39058)
        github.com/golang/protobuf@v1.5.0/proto/table_unmarshal.go:63 +0x66
main.(*TaskStatsResponse).XXX_Unmarshal(0xc00009c870, 0xc0000ee000, 0x18, 0x200, 0xc00009c870, 0xc0000c5e01)
        bufbreaks/structs.new.pb.go:41 +0x65
github.com/golang/protobuf/proto.Unmarshal(0xc0000ee000, 0x18, 0x200, 0x12a7108, 0xc00009c870, 0xc0000c5f40, 0x11f8f7a)
        github.com/golang/protobuf@v1.5.0/proto/decode.go:337 +0x1aa
main.deserialize(0xc0000ee000, 0x18, 0x200)
        bufbreaks/serde.new.go:33 +0x85
main.main()
        bufbreaks/main.go:34 +0xcb
make: *** [test] Error 2
```
