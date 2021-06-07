package main

import (
	"encoding/json"
	"fmt"
	"os"
	"sort"
	"sync"
)

// variables defined outside of func main have PACKAGE LEVEL SCOPE
var wg sync.WaitGroup

///////////////////////////////////////////////////
//////////////////////////////////////////////////

func main() {
	// the program will not execute until all wait groups are done
	// you can increment or decrement
	wg.Add(1) // increment

	greeting("robert")

	// print statement
	// Printf is format print
	// Sprintf is format string print
	// Sprint family returns the formatted string while the Print family just pushes to standard output
	fmt.Println("hello world")

	//bi directional channel
	c := make(chan string)

	// go routine
	// a pattern is to wrap the function in an anonomyous self executing function as the go routine
	// and put the concurrency work in the anon func
	go func() {
		send(c)
		wg.Done() // decrements the number in this wait group
	}()

	// these functions take a specific types of channels
	// but you can go from general to specific with channels.

	// this call is waiting for something from the channel so it BLOCKS
	recieve(c)

	wg.Add(1)
	go func() {
		for i := 0; i < 20; i++ {
			c <- "20 channel sends"
		}
		close(c)
		wg.Done()
	}()

	// ranging over a channel
	// this range will block further execution until the chanel that it pulls from closes.
	for v := range c {
		fmt.Println(v)
	}

	eve := make(chan int)
	odd := make(chan int)
	fin := make(chan string)

	go func() {
		pack(eve, odd, fin)
	}()

	unpack(eve, odd, fin)

	// for loop
	for y := 0; y < 11; y++ {
		fmt.Println(y)
	}

	// 'while loop'
	w := 0
	for {
		if w <= 10 {
			break
		}
		fmt.Println(w)
		w++
	}

	// division
	floorDivision := 83 / 40
	remainder := 83 % 40
	fmt.Println(floorDivision, remainder)

	// continue  skip below continue so only even numbers get printed
	for c := 0; c < 101; c++ {
		if c%2 != 0 {
			continue
		}
		fmt.Println(c)
	}

	// slice literal
	// slice [] of type {...values}
	strSlice := []string{"car", "dog", "cat"}
	intSlice := []int{1, 3, 4, 5, 6}
	fmt.Println(len(intSlice)) // len
	fmt.Println(strSlice[2])   // 2nd index of slice

	// for range
	// like for-of in js or py includes unpacking
	for index, value := range intSlice {
		fmt.Println(index, value)
	}

	// slicing a slice (slicing out of range will throw an error)
	fmt.Println(intSlice[1:4]) // from 1 up to but not including 4

	// append
	// done via assignment. append(what_to_append_to, values_to_append...)
	intSlice = append(intSlice, 40, 50, 60)

	// unpacking/variatic. (like rest)
	// variatic must be last just like js and py
	// you cannot append a slice to a slice of ints so you have to unpack the second slice
	// placing the ...before_the_variable means pack these into a slice
	// placing the after_the_variable... means take this slice and unpack it
	intSlice2 := []int{100, 101, 103}
	intSlice = append(intSlice, intSlice2...)

	// deleting from slice
	// janky act of appending slices while ommiting what you want to delete
	intSlice = append(intSlice[:2], intSlice[4:]...) // slice up to 2 "JOIN" to slice from 4 on

	// sorting
	sortSliceInt := []int{4, 7, 3, 42, 99, 18, 16, 56, 12}
	fmt.Println(sortSliceInt)
	sort.Ints(sortSliceInt) // sorts in place - no return
	fmt.Println(sortSliceInt)

	sortSliceStr := []string{"james", "q", "m", "Moneypenny", "Dr. No"}
	fmt.Println(sortSliceStr)
	sort.Strings(sortSliceStr)
	fmt.Println(sortSliceStr)

	//map (key:value pair that supports itteration)
	//map literal
	myMap := map[string]int{
		"connor":  1990,
		"Lindsay": 1987,
	}
	myMap["burges"] = 1988 // adding to a map
	fmt.Println(myMap)
	fmt.Println(myMap["connor"]) // extracting a value from a map

	// if a key does not exist in a map it returns a 0 value
	fmt.Println("this is not in the map:", myMap["jessica"])

	// comma ok idiom
	// the z is the value returned from the key, the ok is if the key exists in the map
	z, ok := myMap["jessica"]
	fmt.Println(z, ok) // >> 0, false
	// idiomatic check   does the assignment in the if statement ; then uses the ok as the boolean to control the if
	if u, ok := myMap["connor"]; ok {
		fmt.Println(u, "is in the map")
	} else {
		fmt.Println("the key is not in the map")
	}

	// deleting from a map
	delete(myMap, "burges")

	// ranging over a map
	for key, value := range myMap {
		fmt.Println(key, value)
	}

	// struct literal
	person1 := Person{
		First: "Connor",
		Last:  "Strickland",
	}

	// you should create a constructor for structs.
	person2 := NewPerson("bill", "sullivan")
	fmt.Println(person2)

	car1 := Car{
		Year:       1990,
		Model:      "honda",
		Owner:      person1,
		PrevOwners: []string{"bob", "stuart"},
	}
	fmt.Println(car1)

	// Marshal: exporting a struct as JSON
	// Type and Field names must begin with a Capitol letter to be visible outside of the package
	// if you attempt to marshal an unexported struct the JSON object will be empty
	b, err := json.Marshal(car1)
	// standard error checking boiler plate: many methods have 2 return values expected, and error
	// use multiple assignment to "catch both" and if the error exists print immediately after execution
	if err != nil {
		fmt.Println("error:", err)
	}
	os.Stdout.Write(b)

	// Unmarshal
	// unmarshal takes a []byte and an address. it "unpacks" the []bytes to the address. it returns an err to "catch"

	// jsonBlob is assigned to the JSON string after its converted to []byte
	jsonBlob := []byte(`[
		{"Name": "Platypus", "Order": "Monotremata"},
		{"Name": "Quoll", "Order": "Dasyuromorphia"}
    ]`)

	// a struct which matches the JSON structure
	type Animal struct {
		Name  string
		Order string
	}
	// a slice of these structs is declared at zero value getting ready to recieve the unmarshaled JSON
	var animals []Animal
	// unmarshal is passed the blob and the address to send it to
	unMarshalErr := json.Unmarshal(jsonBlob, &animals)
	// the return error is checked
	if unMarshalErr != nil {
		fmt.Println("error:", unMarshalErr)
	}
	// we print the slice of Animal otherwise it is unused
	fmt.Printf("%+v", animals)

	// interface
	// interface: any type that has honk as a method is also a vehicle. Duck test.
	// empty interface (interface{}) all types have at least 0 methods. So all types are also of type empty interface. It feels like type: any.
	type honker interface {
		honk()
	}

	// address
	address := 3412
	fmt.Println(address)  // >> 3412
	fmt.Println(&address) // >> 0xc0000181611

	// pointer
	// pointer type: *int [type pointer to int]
	var pointy *int = &address // or pointy := &address

	// derefrencing a pointer
	fmt.Println(pointy)  // >>  0xc0000181611
	fmt.Println(*pointy) // >> 3412

	// the program will wait until all instances in that wait group are done.
	wg.Wait()
}

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////

// mutex
// mutex will let you lock and unlock a variable so that it cannot be accessed by multiple goroutines
// prevents race conditions

// any := map[string]interface{}
// map string empty interface allows you to create a map where data of any type can be key/value paired to a string
// useful for recieving JSON or other data of unknown shape

//struct
type Person struct {
	First string
	Last  string
}

// constructor or factory
func NewPerson(First string, Last string) Person {
	p := Person{
		First: First,
		Last:  Last,
	}
	return p
}

//embedded struct
type Car struct {
	Year       int
	Model      string
	Owner      Person
	PrevOwners []string
}

func NewCar(Year int, Model string, Owner Person, PrevOwners []string) Car {
	c := Car{Year, Model, Owner, PrevOwners}
	return c
}

// functions
func greeting(name string) {
	fmt.Println("Hello,", name)
}

// sending channel
func send(c chan<- string) {
	c <- "this came through a channel"
}

// recieving channel
func recieve(c <-chan string) {
	fmt.Println(<-c)
}

// takes 3 channels counts to 30 and sends values on to different chans
func pack(eve, odd chan<- int, fin chan<- string) {
	for i := 0; i < 30; i++ {
		if i%2 == 0 {
			eve <- i
		} else {
			odd <- i
		}
	}
	fin <- "all done"
}

// a select lets you organize the output of multiple chans
// a "while loop" loops over the channels until they are empty or closed
// and a "switch like" select block stores the value from chanels and does something with them
// in the order you specify.
// esentially letting you range over multiple chans at once and direct traffic
func unpack(eve, odd <-chan int, fin <-chan string) {
	for {
		select {
		case v := <-eve:
			fmt.Println("from even:", v)
		case v := <-odd:
			fmt.Println("from odd:", v)
		case v := <-fin:
			fmt.Println("from fin:", v)
			return
		}
	}
}

// method
// methods are not set on the struct they are functions that list the struct type as a reciever\
func (c Car) honk() {
	fmt.Println(c.Owner, "HONK!")
}
