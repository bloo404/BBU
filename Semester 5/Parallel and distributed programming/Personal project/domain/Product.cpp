#include "Product.h"
#include <sstream>

std::string Product::toString() {
    std::stringstream ss;
    ss << "Name: " << this->getName() << " | Quantity: " << this->getQuantity() << " | Price: " << this->getPrice() << '\n';
    return ss.str();
}
