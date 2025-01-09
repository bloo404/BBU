//#include <iostream>
//#include <vector>
//#include <chrono>
//
//using namespace std;
//
//vector<int> concatenate( vector<int> A,  vector<int> B) {
//    vector<int> result = A;
//    result.insert(result.end(), B.begin(), B.end());
//    return result;
//}
//
//vector<int> trimZeros( vector<int> poly) {
//    int i = poly.size() - 1;
//    while (i >= 0 && poly[i] == 0) {
//        --i;
//    }
//
//    if (i < 0) {
//        return {0};
//    }
//
//    return vector<int>(poly.begin(), poly.begin() + i + 1);
//}
//
//vector<int> karatsubaMultiply( vector<int> A,  vector<int> B) {
//    int n = 10000;
//
//    vector<int> result(n * 2 - 1, 0);
//
//    if (n <= 4) {
//        for (int i = 0; i < n; ++i) {
//            for (int j = 0; j < n; ++j) {
//                result[i + j] += A[i] * B[j];
//            }
//        }
//        return trimZeros(result);
//    }
//
//    int half = n / 2;
//    vector<int> A0(A.begin(), A.begin() + half);
//    vector<int> A1(A.begin() + half, A.end());
//    vector<int> B0(B.begin(), B.begin() + half);
//    vector<int> B1(B.begin() + half, B.end());
//
//    vector<int> P1(n, 0), P2(n * 2 - 1, 0), P3(n, 0);
//
//    for (int i = 0; i < n; ++i) {
//        P1[i] = A1[i] * B1[i];
//        P3[i] = A0[i] * B0[i];
//    }
//
//    for (int i = 0; i < n; ++i) {
//        for (int j = 0; j < n; ++j) {
//            P2[i + j] += (A1[i] + A0[j]) * (B1[j] + B0[i]);
//        }
//    }
//
//    for (int i = 0; i < n; ++i) {
//        result[i] += P3[i];
//        result[i + half] += P2[i] - P1[i] - P3[i];
//        result[i + 2 * half] += P1[i];
//    }
//
//    return trimZeros(result);
//}
//
//
//
//int main() {
//    auto start = chrono::high_resolution_clock::now();
//    srand(time(NULL));
//
//    vector<int> A, B;
//
//    for (int i = 0; i < 10000; ++i) {
//        A.push_back(i);
//        B.push_back(1);
//    }
//
//    int maxDegree = max(A.size(), B.size());
//    int newSize = 1;
//    while (newSize < maxDegree) newSize *= 2;
//
//    A.resize(newSize, 0);
//    B.resize(newSize, 0);
//
//
//    vector<int> result = karatsubaMultiply(move(A), move(B));
//
//    // 10 000 1513 ms
//
////    cout << "Result Coefficients: ";
////    int cont = 0;
////    for (int i = 0; i < result.size(); i++) {
////        if (i < result.size() - 1)
////            cout << result.at(i) << " * x^" << cont << " + ";
////        else
////            cout << result.at(i) << " * x^" << cont << " ";
////        cont++;
////    }
//
//    cout << endl;
//
//    auto stop = chrono::high_resolution_clock::now();
//    auto duration = chrono::duration_cast<chrono::microseconds>(stop - start) / 1000;
//    cout << "Duration: " << duration.count() << " ms" << endl;
//
//    return 0;
//}
