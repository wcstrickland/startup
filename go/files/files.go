package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strings"
)

func main() {

	// open file
	f, err := os.Open("names.txt")
	if err != nil {
		fmt.Println("error:", err)
		return
	}
	defer f.Close()

	// read into memory
	bs, err := io.ReadAll(f)
	if err != nil {
		fmt.Println("error:", err)
		return
	}

	// convert byte slice to a string and then make it a reader
	r := strings.NewReader(string(bs))

	// create new file
	nf, err := os.Create("names2.txt")
	if err != nil {
		fmt.Println("error:", err)
		return
	}

	//create new file
	af, err := os.Create("names_filtered.txt")
	if err != nil {
		fmt.Println("error:", err)
		return
	}
	defer af.Close()

	// copy r(reader) onto nf(writer)
	io.Copy(nf, r)
	// need to manually close "names2" and reopen it so the coppied values are there
	nf.Close()

	nf, err = os.Open("names2.txt")
	if err != nil {
		fmt.Println("error:", err)
		return
	}
	defer nf.Close()

	// scanner
	// bufio.NewScanner takes a file and returns a scanner and NOT an error
	scanner := bufio.NewScanner(nf)
	err = scanner.Err()
	if err != nil {
		fmt.Println("error:", err)
	}

	// loop over the scanner.Scan() with `for`
	for scanner.Scan() {
		// if the line contains connor
		if strings.Contains(scanner.Text(), "connor") {
			// print to stndout
			fmt.Println(scanner.Text())
			// copy the line onto file
			io.Copy(af, strings.NewReader(scanner.Text()))
		}
	}

}
