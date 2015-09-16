## Psuedo-Code
### Method that takes an array of strings, and returns a string that is all those strings concatenated together

START

Given an array of strings

SET string = ""
SET iterator = 1

WHILE iterator < length of array
	string = string + a space + string value within array at current 'iterator'
	iterator = iterator + 1

PRINT string

END