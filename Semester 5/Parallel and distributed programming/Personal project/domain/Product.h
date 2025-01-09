#pragma once

#include <string>

class Product{
    private:
        std::string name;
        float price;
        int quantity;
    public:
        Product(): name(""), price(0), quantity(0){}
        ~Product(){}
        Product(std::string n, float p, int q){
            this->name = n;
            this->price = p;
            this->quantity = q;
        }

    const std::string &getName() const {return name;}
  //  void setName(const std::string &name) {Product::name = name;}
    float getPrice() const {return price;}
  //  void setPrice(float price) {Product::price = price;}
    int getQuantity() const {return quantity;}
    void setQuantity(int quantity) {Product::quantity = quantity;}

    std::string toString();
};

/*
// graded 8 without
//TODO From time to time, as well as at the end, an inventory check operation shall be run. It shall check that all the sold products and all the money are justified by the recorded bills.
// if that's done, it's a 9 (one week late)

 1. Supermarket inventory:
There are several types of products, each having a known, constant, unit price. In the begining, we know the quantity of each product.
We must keep track of the quantity of each product, the amount of money (initially zero), and the list of bills, corresponding to sales.
Each bill is a list of items and quantities sold in a single operation, and their total price.
We have sale operations running concurrently, on several threads.
Each sale decreases the amounts of available products (corresponding to the sold items), increases the amount of money, and adds a bill to a record of all sales.
Two sales involving distinct products must be able to update their quantities independently (without having to wait for the same mutex). */
