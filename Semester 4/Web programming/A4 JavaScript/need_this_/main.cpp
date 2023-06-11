#include <iostream>
#include <fstream>
using namespace std;
ifstream i("date.in");
ofstream o("date.out");
int main()
{
    char text[256];
    while(i>>text)
        o<<"<option value="<<'"'<<text<<'"'<<">"<<text<<"</option>"<<endl;
    return 0;
}
