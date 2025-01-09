//#include <iostream>
//#include <vector>
//#include <chrono>
//#include <ctime>
//#include <cstdlib>
//
//struct Polynomial {
//    std::vector<int> coefficients;
//
//    Polynomial(std::vector<int> coeffs) : coefficients(std::move(coeffs)) {}
//
//    int degree() const {
//        return coefficients.size() - 1;
//    }
//};
//
//Polynomial multiplyPolynomials(Polynomial A, Polynomial B) {
//    int m = A.degree();
//    int n = B.degree();
//
//    std::vector<int> result(m + n + 1, 0);
//
//    for (int i = 0; i <= m; ++i) {
//        for (int j = 0; j <= n; ++j) {
//            result[i + j] += A.coefficients[i] * B.coefficients[j];
//        }
//    }
//
//    return Polynomial(result);
//}
//
//int main() {
//    auto start = std::chrono::high_resolution_clock::now();
//    srand(time(NULL));
//
//    std::vector<int> temp1 = {};
//    std::vector<int> temp2 = {};
//
//    for(int i=0;i<10000;++i){
//        temp1.push_back(i);
//        temp2.push_back(1);
//    }
//
//    Polynomial A({temp1});  // A(x) = 1 + 2x + 3*x^2
//    Polynomial B({temp2});  // B(x) = 1 + x + x^2
//
//    // 10 000 Duration: 398 ms
//    // 100 000 prea mult
//
//
//    Polynomial result = multiplyPolynomials(A, B);
//
////    std::cout << "Result Coefficients: ";
////    int cont = 0;
////    for (int i = 0; i<result.coefficients.size() - 1;i++) {
////        if (i< result.coefficients.size() - 2)
////            std::cout << result.coefficients.at(i) << " * x^" << cont <<" + ";
////        else
////            std::cout << result.coefficients.at(i) << " * x^" << cont <<" ";
////        cont++;
////    }
//
//    // Result: 1 + 3 x + 6 x^2 + 5 x^3 + 3 x^4
//    // See computed: https://www.wolframalpha.com/input?i=Expand+%28%281+%2B+2*x+%2B+3*%28x%5E2%29%29%28+1+%2B+x+%2B+x%5E2%29%281%29%28+1%29%29
//    // Youtube explanation: https://www.youtube.com/watch?v=AN1O-qUzdxc
//
//    std::cout << std::endl;
//
//    auto stop = std::chrono::high_resolution_clock::now();
//    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start)/1000;
//    std::cout << "Duration: " << duration.count() << " ms" << std::endl;
//
//    return 0;
//}
