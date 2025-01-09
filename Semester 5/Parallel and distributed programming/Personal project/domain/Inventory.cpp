#include "Inventory.h"
#include <sstream>
#include <thread>
#include <mutex>
#include <iostream>

std::string Inventory::toString() {
    std::stringstream ss;
    ss << "Bills: \n";
    for (auto b: this->bills) ss << b.toString();
    ss << "Products: \n";
    for (auto p: this->products) ss << p.toString();
    ss << "Amount of money: " << this->amount_of_money << "\n";
    return ss.str();
}

void Inventory::sell(std::vector<Product> prods) {
    std::vector<Product> sold_products; // concurrent vector without mutex
    std::vector<int> sold_quantities;
    float total = 0;
    for(int i=0; i< prods.size(); i++){
        for(int j=0; j<this->products.size(); j++){
            //std::cout<<"Before acquiring mutex\n";
            std::lock_guard<std::mutex> lock(this->mtxs[j]);
            //std::cout<<"After acquiring mutex\n";
            if(prods[i].getName() == this->products[j].getName()) {
                if (this->products[i].getQuantity() >= prods[j].getQuantity()) {
                    this->products[j].setQuantity(this->products[j].getQuantity() - prods[i].getQuantity());
                    sold_products.push_back(prods[i]);
                    sold_quantities.push_back(prods[i].getQuantity());
                    total += prods[i].getQuantity() * prods[i].getPrice();
                    break;
                }
            }
        }
    }
    this->amount_of_money += total;
    Bill b = Bill(sold_products, sold_quantities, total);
    this->bills.push_back(b);
    std::cout << this->toString();
}

