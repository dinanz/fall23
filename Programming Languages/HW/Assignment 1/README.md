# README
Diana Zhao (dz1371). Programming Languages fall23, HW1

## What works
- Currently, I am able to compile and make/build the file into the csshtml-parser exe through CIMS.
- Implemented most of tokens and grammar.
- Originall I wrote the grammar for css attributes as: property COLON values SEMICOLON, where values goes to STRING values | STRING, and property goes to STRING, but that didn't work with what I have and so I generalised it into ATTRIBUTE. 

## What doesn't work
- Unable to successfully fully parse. I've added the trace; it does parse up until certain points.
- Have not implemented getting the depth.
- Haven't implemented verifying start tag = end tag.