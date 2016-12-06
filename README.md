# ReadOnce

Readonce is a command line utility for sharing passwords and other private information with exactly one person.

This CLI takes any data from STDIN, pushes it to the [readonce-server web service](https://github.com/freerobby/readonce-server), and returns a unique URL where the data can be queried exactly once.

As soon as the first request for a given key is received by the web service, its associated data are deleted.

## Installation

`gem install readonce` -- that's it!

## Usage

To share a line of text, such as a password, use:

`echo "foobar123" | readonce`

To share a file, such as a private key, use:

`readonce < mykey.pem`

You can check whether your readonce data has been accessed with:

`readonce -s <key>`

Or, you can have readonce block until it has been accessed, so you can see exactly when the recipient has viewed it:

`readonce -w < mykey.pem` or `readonce -w <key>`


## License

The library is released under the [MIT License](http://opensource.org/licenses/MIT).

