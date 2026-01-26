basically we group before processing

line by line
- morse
- tomtom

single row only
- morse
- tomtom

multirow
// TODO

single letter

# Braille

Pin code input is same in phones. Matching list of numbers in order.

# Tallymarks

Lines intersecting where 4 lines intersecting with 1 vertical line represent 5. Single that are not intersecting lines represents 1. Everytime number 5:s are found they should be removed from inspectable lines. At the start all lines that intersect could be filtered. There can be errors like 3 vertical lines intersected by 1 horizontal line. Easiest is by simply not counting. UX problem.

# Morse Code

Every line represent something. Order horizontally matters. Just like strings all lines in list can be split by stop signs. Then processed as lists.

# Ogham Script

Same as morse code.

# Identifier vs value

Especially using morse code taught using enums to represent each letter is important. Ogham script teaches that there is unicode representation and latin representation. Here doing second time made realize it would have been good to implement class for letter that contains representation and enum. Lets call this and punctuation and all else letter until better name appears. Use BaseLetter class.

# Testing

Creating data for testing is sort of issue when don't know what type of letters human needs. After certain point there seem to build up confidence of creating data for testing. On the other hand if code is small enough manual testing should be enough. Better quality needs test data builder. Do when "solidified".

# Communication

Here using pattern recognition as way to communicate how identifiers are collected and constructing test data to visualization would be great.

# Pigpen script

Yes. In a sense we could solve the issue of corner and curve. In a sense it is not a problem. Add more line strokes! Borrowing idea from Hangul. Corner and curve consist of 

# Early Greek Alphabet

https://en.wikipedia.org/wiki/File:NAMA_Alphabet_grec.jpg

1. bounding box => add to list
2. intersect => add to list
3. process

Simple.


