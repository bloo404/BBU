#include "Bill.h"
#include <sstream>

std::string Bill::toString() {
    std::stringstream ss;
    ss << "---------------------------------------------------------------------\n";
    ss << "------------------------------ B I L L ------------------------------\n";
    ss << "---------------------------------------------------------------------\n";
    for (int i = 0; i < this->product_list.size(); i++)
        if(product_list[i].getQuantity()!=0)
            ss << product_list[i].toString();
    ss << "---------------------------------------------------------------------\n";
    return ss.str();
}
