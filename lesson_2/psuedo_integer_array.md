## Psuedo-Code
### Method that takes an array of integers, and returns a new array with every other element

START

Given an array of integers

SET new_array = []
SET iterator = 1

WHILE iterator < length of integer array
	IF iterator is odd
		push number from array into new_array
	ELSE
		go to the next iteration

	iterator = iterator + 1

PRINT new_array

END