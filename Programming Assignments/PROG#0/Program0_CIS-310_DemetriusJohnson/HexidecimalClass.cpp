

#include "HexidecimalClass.h"


HexidecimalClass::HexidecimalClass() { //default constructor
	

}
HexidecimalClass& HexidecimalClass::operator=(float decimalNumber) {

	hexVal[0] = 48; //from ASCII, decimal 30 is the equivalent of char '0'
	hexVal[1] = 48;
	//use the above to reset the hex digits to 00 (char characters '0')

	wholeNum = decimalNumber; //use this variable to store the non fractional portion of the decimal number
	fractionDigits = decimalNumber - wholeNum; //use this variable to store the decimal digits (if any) of the passed decimal value 

	//I made the above in such a way as for if I ever extend this program to convert decimal digits with digits in place values to the right of the decimal as well

	decimalVal = decimalNumber; //set decimal value for the Hex object to the passed-in decimal number simply for storage purposes of the object's decimal equivalent
	int remainder = 0; //use this to keep track of wether or not a division will leave a remainder
	int elementPos = 1; //element position variable used to keep track of where to input the next value (0-F) into the Hexidecimal number (the char array)

	while (wholeNum != 0) {


		remainder = (wholeNum % 16) + 48; //obtain remainder of a division by 16 
									//using ASCII we add 48 (48-57 is '0'-'9' char, since a char data structure defines its output based on this standard
		if (remainder > 57) { //execute this loop to obtain digits 10-15 (characters A-F) of base 16 place value numbers

			remainder += 7; //58+7 == 65 which is 'A' for the char data type

		}
		
		hexVal[elementPos] = remainder; //set the proper place value to the appropriate number (0-F)
										  
		wholeNum /= 16; //perform integer division by 16 (finishing the last step in this iteration of the algorithm)
	
		elementPos--; //decrement place value to go to the next place value (moving from right to left according to the algorithm)

	}

	return *this;
}

char* HexidecimalClass::getHexValue(void) { return hexVal; }//use this to get the hexidecimal value so that we can output it in main 
															//must return a reference since I have the hex valued stored in a char array

