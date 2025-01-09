#include <iostream>
#include "Inventory.h"

int main(){
    std::vector<Bill> bills;
    std::vector<Product> my_products;

    Product p = Product("Apple", 1.0, 10);
    my_products.push_back(p);
    p = Product("Banana", 0.5, 20);
    my_products.push_back(p);
    p = Product("Carrot", 0.3, 15);
    my_products.push_back(p);
    p = Product("Orange", 1.2, 25);
    my_products.push_back(p);
    p = Product("Lettuce", 0.8, 12);
    my_products.push_back(p);
    p = Product("Tomato", 0.6, 18);
    my_products.push_back(p);
    p = Product("Cucumber", 0.7, 8);
    my_products.push_back(p);
    p = Product("Grapes", 1.5, 15);
    my_products.push_back(p);
    p = Product("Spinach", 0.4, 30);
    my_products.push_back(p);
    p = Product("Kiwi", 1.0, 25);
    my_products.push_back(p);
    p = Product("Pear", 1.2, 12);
    my_products.push_back(p);
    p = Product("Broccoli", 0.9, 40);
    my_products.push_back(p);
    p = Product("Strawberries", 1.8, 20);
    my_products.push_back(p);
    p = Product("Mango", 1.5, 15);
    my_products.push_back(p);
    p = Product("Bell Pepper", 0.7, 10);
    my_products.push_back(p);

    Inventory my_inventory(my_products, bills, 0); // produse & facturi & initial amount of money

    std::vector<Product> to_buy;
    Product p1("Apple", 1.0, 8); // 8
    Product p2("Banana", 0.5, 20); // too many     //10
    Product p3("Carrot", 0.3, 10); // 3
    Product p4("Orange", 1.2, 15); // 18
    Product p5("Blueberries", 0.8, 5); // not in list

    to_buy.push_back(p1);
    to_buy.push_back(p2);
    to_buy.push_back(p3);
    to_buy.push_back(p4);
    to_buy.push_back(p5);

    // thread name([reference, copie])(){} -> instantiere, then {aplica to_buy in functia sell}
    std::thread t1([&my_inventory, to_buy]() { my_inventory.sell(to_buy); });
    std::thread t2([&my_inventory, to_buy]() { my_inventory.sell(to_buy); });
    std::thread t3([&my_inventory, to_buy]() { my_inventory.sell(to_buy); });
    std::thread t4([&my_inventory, to_buy]() { my_inventory.sell(to_buy); });
    std::thread t5([&my_inventory, to_buy]() { my_inventory.sell(to_buy); });

    t1.join();
    t2.join();
    t3.join();
    t4.join();
    t5.join();

    return 0;
}