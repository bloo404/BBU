#include <iostream>
#include <cstring>
#include <fstream>
using namespace std;
ifstream fin("text.txt");
ofstream fout("newText.txt");
/// aici vezi codul
int main()
{
    char vocale[11]="aeiouAEIOU";
    char text[1000];
    char newText[3000];
    fin.get(text, 1000);
    int x=0;
    for(int i=0;i<strlen(text);i++)
    {
        newText[x]=text[i];
        x++;
        if(strchr(vocale,text[i])!=NULL)
        {
            newText[x]='b';
            x++;
            newText[x]='l';
            x++;
        }
    }
    for(int i=0;i<strlen(newText);i++)
        fout<<newText[i];
    fout<<endl;
    return 0;
}
