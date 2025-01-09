//#include <iostream>
//#include <vector>
//#include <thread>
//#include <mutex>
//#include <chrono>
//
//struct Polynomial {
//    std::vector<int> coefficients;
//
//    Polynomial(std::vector<int> coeffs) : coefficients(std::move(coeffs)) {}
//
//    int degree()  {
//        return coefficients.size() - 1;
//    }
//};
//
//std::mutex resultMutex;
//
//void multiplyRange( Polynomial& A,  Polynomial& B, std::vector<int> result, int start, int end) {
//    int n = B.degree();
//
//    for (int i = start; i <= end; ++i) {
//        for (int j = 0; j <= n; ++j) {
//            std::lock_guard<std::mutex> lock(resultMutex);
//            result[i + j] += A.coefficients[i] * B.coefficients[j];
//        }
//    }
//}
//
//Polynomial multiplyPolynomials(Polynomial A, Polynomial B) {
//    int m = A.degree();
//    int n = B.degree();
//
//    std::vector<int> result(m + n + 1, 0);
//
//     int numThreads = 3; // available threads in hardware // 100 threads, 10 000 pol degree Duration: 24371 ms
//
//    std::vector<std::thread> threads;
//    int rangeSize = (m + 1) / numThreads;
//
//    for (int i = 0; i < numThreads; ++i) {
//        int start = i * rangeSize;
//        int end = (i == numThreads - 1) ? m : (start + rangeSize - 1);
//        threads.emplace_back(multiplyRange, std::ref(A), std::ref(B), std::ref(result), start, end);
//    }
//
//    for (auto& thread : threads) {
//        thread.join();
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
//    // 10 000 Duration: 6757 ms why? banuiesc ca aloca mai putina memorie pentru fiecare separat si dureaza mai mult, iar la sequential foloseste toata memoria pt fiecare calcul in parte
//
//    Polynomial result = multiplyPolynomials(A, B);
//
////    std::cout << "Result Coefficients: ";
////    int cont = 0;
////    for (int i = 0; i < result.coefficients.size(); i++) {
////        if (i < result.coefficients.size() - 1)
////            std::cout << result.coefficients.at(i) << " * x^" << cont << " + ";
////        else
////            std::cout << result.coefficients.at(i) << " * x^" << cont << " ";
////        cont++;
////    }
//
//    std::cout << std::endl;
//
//    auto stop = std::chrono::high_resolution_clock::now();
//    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start)/1000;
//    std::cout << "Duration: " << duration.count() << " ms" << std::endl;
//
//
//    return 0;
//}
