// +build old,!new

package main

import (
	"fmt"
	"log"
	"time"

	"github.com/golang/protobuf/proto"
	"github.com/golang/protobuf/ptypes"
)

func serialize() []byte {
	now, _ := time.Parse(time.RFC3339, "2021-05-05T13:49:19Z-05:00")
	started, _ := ptypes.TimestampProto(now)
	resp := &TaskStatsResponse{
		Stats: &TaskStats{
			Id:        "example",
			Timestamp: started,
		},
	}

	blob, err := proto.Marshal(resp)
	if err != nil {
		log.Fatal("error serializing: %v", err)
	}
	return blob
}

func deserialize(in []byte) {
	resp := &TaskStatsResponse{}
	err := proto.Unmarshal(in, resp)
	if err != nil {
		log.Fatal("error deserializing: %v", err)
	}
	fmt.Printf("%#v\n", resp)
	fmt.Printf("%x\n", in)
}
