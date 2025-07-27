


#ifndef BINARYCLASS_H

#define BINARYCLASS_H

class BinaryClass
{

private:

	float decimalVal; //used to store the object's decimal value
	int binaryVal; //used to store the object's binary value
	int wholeNum; //use this variable to capture only the digits greater than or equal to 1 (whole numbers/digits to the left of the decimal)
	float fractionDigits; //use this variable to store the decimal digits (if any) of the passed decimal value 
	int outputArray[8] = {0}; //use this array to make outputting easier in main for my table
public:
	BinaryClass& operator=(double decimalNumber);
	BinaryClass(); //default constructor

	int getBinaryVal(void); //use this to get the binary value so that we can output it in main

	int* getBinArray(void); //return a reference to the binary int array





};


#endif