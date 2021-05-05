package main

import (
	"io/ioutil"
	"log"
	"os"
)

const filename = "example.bin"

func toFile(in []byte) {
	err := ioutil.WriteFile(filename, in, 0644)
	if err != nil {
		log.Fatal(err)
	}
}

func fromFile() []byte {
	blob, err := ioutil.ReadFile(filename)
	if err != nil {
		log.Fatal(err)
	}
	return blob
}

func main() {
	if len(os.Args) != 2 {
		log.Fatal("1 arg required: \"write\" or \"read\"")
	}
	if os.Args[1] == "write" {
		toFile(serialize())
		return
	} else if os.Args[1] == "read" {
		deserialize(fromFile())
		return
	}
	log.Fatal("wrong arg!")
}
