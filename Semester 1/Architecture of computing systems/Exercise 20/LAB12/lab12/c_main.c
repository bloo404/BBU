// Read from file numbers.txt a string of numbers. Build a string D wich contains the readen numbers doubled and in reverse order that they were read. Display the string on the screen.
//     Ex: s: 12, 2, 4, 5, 0, 7 = > 14, 0, 10, 8, 4, 24

#include <stdio.h>

int dublu( int x );

int printer(int x);

int main()
{
	// declaring the initial variables that we are going to use
	int a[100], x, pos = 0;
	FILE *fp;
	
	// opening the file we re going to read from
	fp = fopen( "numere.txt", "r" );
	
	// while there is something to read, we compute the double and put it in a vector
	while ( !feof( fp ) )
	{
		fscanf( fp, "%d,", &x );
		a[pos] = dublu(x);
		pos++;
	}

	// we print the doubled reversed numbers
	printf("Output is: ");
	for ( int i = pos - 1; i>=0; i-- )
		printer(a[i]);
        
        
}

