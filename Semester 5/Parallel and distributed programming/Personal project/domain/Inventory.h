#pragma once

#include "Bill.h"
#include "Product.h"
#include <thread>
#include <mutex>

class Inventory {
private:
    std::vector<Product> products;
    std::vector<Bill> bills;
    std::mutex mtxs[100];
    float amount_of_money{};
public:
    Inventory() : products(std::vector<Product>(100)), bills(std::vector<Bill>(100)), amount_of_money(0) {}

    Inventory(std::vector<Product> p, std::vector<Bill> b, float am) : products(p), bills(b), amount_of_money(am) {}

    ~Inventory() {}

    std::string toString();

    void sell(std::vector<Product> prods);
};
