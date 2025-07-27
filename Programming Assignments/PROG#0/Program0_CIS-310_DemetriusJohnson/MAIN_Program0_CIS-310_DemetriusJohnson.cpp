// Program0_CIS-310_DemetriusJohnson.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

/*

Program # 0
CIS 310 (Yoon)
SUMMER 2021
Upload it by Mid-night, 5/16/21 (Sun)

Write a program in C or C++  that converts decimal numbers to binary, hexadecimal, and BCD (Binary Coded Decimal). 
You are not allowed to use library functions to do conversion.  The output should look as follows.  
Send the output to a file and upload it along with your source file.


DECIMAL 	BINARY		HEXDECIMAL		        BCD
0		    0000 0000		00				0000 0000 0000
1		    0000 0001		01				0000 0000 0001
2		    0000 0010		02				0000 0000 0010
.		    .		         .				   .
.		    .		         .		           .
255		    1111 1111       FF		        0010 0101 0101


For uploading information, see the file called SYLLABUS/GUIDELINE.






*/


#include <iostream>
#include <fstream>
#include "BinaryClass.h"
#include "HexidecimalClass.h"
#include <string>
#include <iomanip> //use this to output a table
using namespace std;

int main()
{
    
    fstream outPut_LogFile_txt;
    BinaryClass BinaryNum; //use this to convert and store the decimal number and the corresponding binary number
    BinaryClass BCD;//use this to encode decimal digits using BCD
    HexidecimalClass HexNum; //use this to convert and store dec num to their Hex values
    int counter = 0; //use this counter to iterate from 0 to 255 to output it to a table and a log file
    char* hexValue_address; //get the array address of the hex value
    int* binValue_address; //get the array address of the bin value
    int* BCD_address; //get the array address of the bin value from BCD variable
    int BCD_array[3] = { 0 }; //use this to write each digit of a decimal digit from 0-9 as a separate binary value
    int multiplier = 100; //use this multiplier variable to control which place value we are acquiring
    int counterHolder = counter; //will manipulate counter in function, so must make a holder variable so as not to disrupt which iteration and decimal number we are on for the loop
 
    
    cout << "\n\n--------WELCOME TO THE SIMPLE DECIMAL TO BINARY, HEXIDECIMAL, OR BCD CONVERSION PROGRAM ----\n---BY Demetrius Johnson-------\n\n";
    cout << "DECIMAL" << setw(18) << "BINARY" << setw(27) << "HEXIDECIMAL" << setw(48) << "BCD (Binary-Coded Decimal)" << setw(20) << "\n\n"; //table header

   //the following while-loop will be used to output a table of the values

    while (counter <= 255) {

        BinaryNum = counter; //object stores the decimal number and converts it to binary and stores it as well
        HexNum = counter; //object stores the decimal number and converts it to hexidecimal and stores it as well
        hexValue_address = HexNum.getHexValue();
        binValue_address = BinaryNum.getBinArray();
      
        cout << counter << setw(17); //output the decimal value

        //below is the code to output the binary value
        for (int i = 0; i < 8; i++) {

            if (i == 4) {
                cout << " ";
            }

           cout << *(binValue_address + i);
        }//use this loop to output binary values with a space in between for readability 
        cout << setw(19);

        //use the below statement to output hex value
        cout << *(hexValue_address++) << *hexValue_address << setw(38);
            
        //the below code will parse the counter variable so that each place value can be input into the BCD_array for table output use

        multiplier = 100; //use this multiplier variable to control which place value we are acquiring
        counterHolder = counter; //will manipulate counter in function, so must make a holder variable so as not to disrupt which iteration and decimal number we are on for the loop
        for (int j = 0; j < 3; j++) {

            BCD_array[j] = counterHolder / multiplier; //get each place value from the counter beginning with 1000s place and store it in the array
            counterHolder = counterHolder - (BCD_array[j] * multiplier); //get rid of the place value that we already stored in the array

            multiplier /= 10; //reduce the multiplier to the next place value

            BCD = BCD_array[j]; //acquire the binary version of the decimal place value
            BCD_address = BCD.getBinArray();
            for (int k = 4; k < 8; k++) { //use k= 4 through 7 since elements 4-7 are the elements that contain the first 4 digits of the binary value

                cout << *(BCD_address + k);

            }//use this loop to output binary values with a space in between for readability 
            cout << " ";
           
        } //use this loop to parse the each place value of the decimal digit (counter) in order to write it as BCD
           
        cout << endl;
        if (counter == 9 || counter == 99) { cout << endl; } //add extra space when decimal digit increases


        counter++;

    }

    //--
    //use the next following code and the while loop to output the same cout output to a text file
    //--

    outPut_LogFile_txt.open("logFile.txt", ios::out); //open the output file
    if (outPut_LogFile_txt.is_open()) { cout << "\n\n~output log file opened successfully~\n\n "; } //check to make sure file is opened successfully
    counter = 0; //reset counter for output file while loop

    outPut_LogFile_txt << "\n\n--------WELCOME TO THE SIMPLE DECIMAL TO BINARY, HEXIDECIMAL, OR BCD CONVERSION PROGRAM---\n----BY Demetrius Johnson-------\n----LOG OUTPUT FILE ----\n\n";
    outPut_LogFile_txt << "DECIMAL" << setw(18) << "BINARY" << setw(27) << "HEXIDECIMAL" << setw(48) << "BCD (Binary-Coded Decimal)" << setw(20) << "\n\n"; //table header

    while (counter <= 255) {

        BinaryNum = counter; //object stores the decimal number and converts it to binary and stores it as well
        HexNum = counter; //object stores the decimal number and converts it to hexidecimal and stores it as well
        hexValue_address = HexNum.getHexValue();
        binValue_address = BinaryNum.getBinArray();

        outPut_LogFile_txt << counter << setw(28); //output the decimal value

        //below is the code to output the binary value
        for (int i = 0; i < 8; i++) {

            if (i == 4) {
                outPut_LogFile_txt << " ";
            }

            outPut_LogFile_txt << *(binValue_address + i);
        }//use this loop to output binary values with a space in between for readability 
        outPut_LogFile_txt << setw(23);

        //use the below statement to output hex value
        outPut_LogFile_txt << *(hexValue_address++) << *hexValue_address << setw(44);

        //the below code will parse the counter variable so that each place value can be input into the BCD_array for table output use

        multiplier = 100; //use this multiplier variable to control which place value we are acquiring
        counterHolder = counter; //will manipulate counter in function, so must make a holder variable so as not to disrupt which iteration and decimal number we are on for the loop
        for (int j = 0; j < 3; j++) {

            BCD_array[j] = counterHolder / multiplier; //get each place value from the counter beginning with 1000s place and store it in the array
            counterHolder = counterHolder - (BCD_array[j] * multiplier); //get rid of the place value that we already stored in the array

            multiplier /= 10; //reduce the multiplier to the next place value

            BCD = BCD_array[j]; //acquire the binary version of the decimal place value
            BCD_address = BCD.getBinArray();
            for (int k = 4; k < 8; k++) { //use k= 4 through 7 since elements 4-7 are the elements that contain the first 4 digits of the binary value

                outPut_LogFile_txt << *(BCD_address + k);

            }//use this loop to output binary values with a space in between for readability 
            outPut_LogFile_txt << " ";

        } //use this loop to parse the each place value of the decimal digit (counter) in order to write it as BCD

        outPut_LogFile_txt << endl;
        if (counter == 9 || counter == 99) { outPut_LogFile_txt << endl; } //add extra space when decimal digit increases


        counter++;

    }

    cout << "\nProgram has finished executing successfully; thank you(: goodbye\n\n";
    system("pause");
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
