

#include "BinaryClass.h"

BinaryClass::BinaryClass() {

	decimalVal = 0; //used to store the object's decimal value
	binaryVal = 0;//used to store the object's binary value
	wholeNum = 0; //use this variable to capture only the digits greater than or equal to 1 (whole numbers/digits to the left of the decimal)
	fractionDigits = 0; //use this variable to store the decimal digits (if any) of the passed decimal value 



}
BinaryClass& BinaryClass::operator=(double decimalNumber) {

	binaryVal = 0; //need to reset the binary value everytime the =operator is called otherwise it will be manipulated while old data is still stored in the variable
	wholeNum = decimalNumber; //use this variable to store the non fractional portion of the decimal number
	fractionDigits = decimalNumber - wholeNum; //use this variable to store the decimal digits (if any) of the passed decimal value 

	//I made the above in such a way as for if I ever extend this program to convert decimal digits with digits in place values to the right of the decimal as well

	for (int i = 0; i < 8; i++) { //reset output array values to all 0s

		outputArray[i] = 0;

	}

	decimalVal = decimalNumber; //set decimal value for the binary object to the passed-in decimal number simply for storage purposes of the object's decimal equivalent
	int powerOf_10 = 1; //use this to go to the next power of 10 for each time we have to divide the decimal by 2 when converting ot binary
	int remainder = 0; //use this to keep track of wether or not a division will leave a remainder
	int counter = 7; //use this to keep track of counter for the outputArray to store the binary values

	while (wholeNum != 0) {

		
		remainder = wholeNum % 2; //obtain remainder of a division by 2
		wholeNum /= 2; //perform integer division by 2
		if (remainder != 0) { 
			//if remainder exists, then we use the algorithm for converting to binary; that is, when there is a remainder after dividing by two, we place a '1' in the next binary place value
			
			binaryVal += powerOf_10; //for example if current value is 001, then adding the next power of 10 value will cause it to be 1000 + 001 == 1001

			outputArray[counter] = remainder; //store the next binary digit in the output array
			counter--; //must decrement since values must be added from right to left (++ causes values to be added from left to right from starting at the 0 element and onward.
		}
		else{ //remainder is 0; thus place a 0 in the next place value for the output array
			
			outputArray[counter] = remainder;
			counter--;
			
		}
		


		powerOf_10 *= 10; //increase power of 10 for the next possible loop so that we go to the next binary place value in order to add a 1 or 0
		
	}



	return *this;
}

int BinaryClass::getBinaryVal(void) { return binaryVal; } //use this to get the binary value so that we can output it in main


int* BinaryClass::getBinArray() { return outputArray; }