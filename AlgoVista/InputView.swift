////
////  InputView.swift
////  AlgoVista
////
////  Created by Inzamam on 19/12/23.
////
//// InputView.swift
//// AlgoVista
//
//// InputView.swift
//
//import SwiftUI
//
//struct InputView: View {
//    @Binding var isPresented: Bool
//    @Binding var numbers: [Int]
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Enter 10 numbers separated by commas:")
//                    .padding(.bottom, 10)
//
//                TextField("e.g., 5, 8, 3, ...", text: Binding(
//                    get: { numbers.map(String.init).joined(separator: ", ") },
//                    set: { input in
//                        numbers = input
//                            .split(separator: ",")
//                            .compactMap { Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
//                    }
//                ))
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.bottom, 20)
//
//                NavigationLink(destination: ContentView(numbers: $numbers, isPresented: $isPresented)) {
//                    Text("Sort Now!")
//                        .foregroundColor(.white)
//                        .padding(10)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .padding(.top, 30)
//            }
//            .padding()
//            .navigationBarTitle("Input Numbers")
//        }
//    }
//}
