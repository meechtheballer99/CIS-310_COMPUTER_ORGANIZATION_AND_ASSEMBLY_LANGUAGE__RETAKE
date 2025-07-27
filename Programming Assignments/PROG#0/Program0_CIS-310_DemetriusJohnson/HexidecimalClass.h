


#ifndef HEXIDECIMALCLASS_H

#define HEXIDECIMALCLASS_H

class HexidecimalClass
{



private:

	float decimalVal = 0; //used to store the object's decimal value
	char hexVal[2] = {48}; //used to store the object's hexidecimal value //must use char array since hexidecimal is base 16 (0-F for each place value)
						   //{48} initializes every element to the '0' character --> equivalent to doing: hexVal[2] = {'0'} --NOTE the difference between 0 and '0'
	int wholeNum = 0; //use this variable to capture only the digits greater than or equal to 1 (whole numbers/digits to the left of the decimal)
	double fractionDigits = 0; //use this variable to store the fractional decimal digits (if any) of the passed decimal value 
	

public:
	HexidecimalClass& operator=(float decimalNumber);
	HexidecimalClass(); //default constructor

	char* getHexValue(void); //use this to get the hexidecimal value so that we can output it in main



};

#endif