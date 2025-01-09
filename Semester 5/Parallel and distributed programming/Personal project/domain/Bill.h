#pragma once

#include <Product.h>
#include <vector>

// Each bill is a list of items and quantities sold in a single operation, and their total price.
class Bill {
    private:
        std::vector<Product> product_list; // total_price = product*this_quantity
        std::vector<int> quantity_list;
        float total;
    public:
        Bill(): product_list(std::vector<Product>(100)), quantity_list(std::vector<int>(100)), total(0){}
        Bill(std::vector<Product> p, std::vector<int> q, float t): product_list(p), quantity_list(q), total(t){}
        ~Bill(){}

    std::string toString();
};
