// +build new,!old

package main

import (
	"fmt"
	"log"
	"time"

	"google.golang.org/protobuf/proto"
	timestamppb "google.golang.org/protobuf/types/known/timestamppb"
)

func serialize() []byte {
	now, _ := time.Parse(time.RFC3339, "2021-05-05T13:49:19Z-05:00")
	started := timestamppb.New(now)
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
