package com.my.org.erp.example.util;

import java.util.Arrays;
 
 
 
public class ArraysMethodTester {
 
    private char[] myArray = {'b', 'e', 'd', 'h','j',
 
            'a', 'c', 'f', 'g', 'i'};
 
 
 
    public char[] getArray(){
 
        return myArray;
 
    }
 
 
 
    public static void main(String[] args) {
 
        ArraysMethodTester test = new ArraysMethodTester();
 
        char[] firstArray = test.getArray();
 
        char[] secondArray = test.getArray().clone();
 
 
 
        // Compare two arrays
 
        if (Arrays.equals(firstArray, secondArray)) {
 
            System.out.println("The two arrays are equal!");
 
        } else {
 
            System.out.println("The two arrays are not equal!");
 
        }
 
 
 
        firstArray[8] = 'k';
 
 
 
        // Print array
 
        System.out.println("Unsorted array...");
 
        System.out.println(Arrays.toString(firstArray));
 
        System.out.println();
 
 
 
        // Sort the array
 
        Arrays.sort(firstArray);
 
 
 
        // print sorted array
 
        System.out.println("Sorted array...");
 
        System.out.println(Arrays.toString(firstArray));
 
        System.out.println();
 
 
 
        // Get the index of a particular value
 
        int index = Arrays.binarySearch(firstArray, 'k');
 
        System.out.println("k is located in the array at index " + index);
 
        System.out.println();
 
 
 
        String[][] ticTacToe = {
 
                { "#", "O", "O" },
 
                { "O", "#", "#" },
 
                { "#", "O", "#" } };
 
 
 
        System.out.println(Arrays.deepToString(ticTacToe));
 
        System.out.println();
 
 
 
        String[][] ticTacToe2 = {
 
                { "O", "O", "#" },
 
                { "O", "#", "#" },
 
                { "#", "O", "#" } };
 
 
 
        String[][] ticTacToe3 = {
 
                { "#", "O", "O" },
 
                { "O", "#", "#" },
 
                { "#", "O", "#" } };
 
 
 
        if (Arrays.deepEquals(ticTacToe, ticTacToe2)) {
 
            System.out.println("Boards 1 and 2 are equal.");
 
        } else {
 
            System.out.println("Boards 1 and 2 are not equal.");
 
        }
 
 
 
        if (Arrays.deepEquals(ticTacToe, ticTacToe3)) {
 
            System.out.println("Boards 1 and 3 are equal.");
 
        } else {
 
            System.out.println("Boards 1 and 3 are not equal.");
 
        }
 
    }
 
}
