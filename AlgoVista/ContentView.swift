//  ContentView.swift
//  AlgoVista
//
//  Created by Inzamam on 16/12/23.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    
    var input: [Int] // computed propety
    {
        var array = [Int]()
        for i in 0...15{
            array.append(i)
        }
        return array
            .shuffled()
    }
    
    @State var data = [Int]()
    @State var activeValue = 0
    @State var previousValue = 0
    @State private var elementsSorted = [Int]()
    @State private var isSorting = false
    @State private var stopSorting = false
    @State private var pressed = false
    
    
    var body: some View {
        
        VStack {
            Chart{
                ForEach(Array(zip(data.indices,data)),id:\.0){ index, item in
                    BarMark (
                        x: .value("Position", index),
                        y: .value("Value", item)
                    )
                    
//                    .annotation{
//                        Text("\(item)")
//                            .font(.footnote)
//                            .foregroundColor(.red)
//                    }
//                    // commented out because its starting from -20 donno why
                    
                    .foregroundStyle(getColor(value: item).gradient)
                }
                
            }
            //.chartXScale(domain: 0...10)
            
            HStack(spacing: 30) {
 //               if pressed == false {
                    Button{
                        Task{
                            if isSorting {
                                stopSorting = true
                                pressed = false
                            } else {
                                pressed = true
                                try await bubblesort()
                            }
                            
                        }
                    } label: {
                        if isSorting{
                            Text("Stop").foregroundColor(.white).padding(.horizontal, 30)
                        }
                        else if stopSorting{
                            Text("Stopped!").foregroundColor(.white).padding(.horizontal, 10)
                            
                        }
                        else
                        {
                            Text("Sort Now!   ").foregroundColor(.white)
                        }
                        
                    }
                    .padding(10)
                    .background(
                        isSorting
                        ? (stopSorting ? Color.gray : Color.red)
                        : (stopSorting ? Color.gray : Color.green)
                    )
                    .cornerRadius(10)
                .padding(.top, 30)
 //               }
                
                
                if pressed == false {
                    Button{
                        stopSorting = false
                        // isSorting = false
                        elementsSorted.removeAll()
                        activeValue = 0
                        previousValue = 0
                        data = input
                        
                    } label: {
                        Text("Re-Shuffle ↻")
                            .foregroundColor(.white)
                    }
                    .padding(10)
                    .background(Color.black)
                    .cornerRadius(10)
                .padding(.top, 30)
                }
            }
            
            
            
            
        }
        .onAppear{
            data = input
            // elementsSorted.removeAll()
        }
        .padding(30)
        .padding(.top, 30)
        .background(Color(UIColor(hex: "#D0D9EA"))).ignoresSafeArea(.all)
    }
    
    func bubblesort() async throws {
        guard data.count > 1
        else {return}
        
        isSorting = true
        
        for i in 0..<data.count {
            for j in 0..<data.count-i-1 {
                if stopSorting {
                    isSorting = false
                    
                    return
                }
                
                activeValue = data[j+1]
                previousValue = data[j]
                
                if data[j]>data[j+1] {
                    data.swapAt(j+1,j)
                    try await Task.sleep(until: .now.advanced(by: .milliseconds (400)), clock: .continuous)
                    // try await Task.sleep(until: .now.advanced(by: .milliseconds (50)), clock: .continuous)
                }
                
            }
            elementsSorted.append(data.count-i-1)
            //   elementsSorted += 1
            print("elementsSorted: \(elementsSorted)")
        }
        isSorting = false
        
    }
    
    func getColor(value: Int) -> Color{
        if elementsSorted.contains(value)  {
            return .purple
        }
        else if value == activeValue{
            return .green
        }
        else if value == previousValue {
            return .yellow
        }
        
        return .cyan
        
        
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


#Preview {
    ContentView()
}

