//
//  ScreenSwitcher.swift
//  AppSUI_HW_02
//
//  Created by Сергей Смирнов on 30/7/23.
//

import SwiftUI
import UISystem

struct ScreenSwitcher: View {
    
    var pickerOptions = ["Apple", "Tesla", "NASA"]
    @State var pickerVariant = 0
    
    var body: some View {
        NavStack(transition: .custom(.moveAndFade)){
            VStack {
                Picker("", selection: $pickerVariant) {
                    ForEach(0..<pickerOptions.count, id: \.self) {i in
                        Text(self.pickerOptions[i])
                            .tag(i)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                switch pickerVariant {
                case 0:
                    NewsScreen(rubric: "Apple")
                case 1:
                    NewsScreen(rubric: "Tesla")
                case 2:
                    NewsScreen(rubric: "NASA")
                default:
                    EmptyView()
                }
                NavStackPush(destination: SecondScreen()) {
                    Text("Push to #2")
                        .padding()
                        .background(Color.teal)
                }
                
            }
        }
    }
}

struct SecondScreen: View {
    
    var body: some View {
        VStack {
            Text("#2")
                .font(.system(size: 200))
            Divider()
            NavStackPop(destination: .previous) {
                Text("Pop to #1")
                    .padding()
                    .background(Color.teal)
            }
            NavStackPush(destination: ThirdScreen()) {
                Text("Push to #3")
                    .padding()
                    .background(Color.teal)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.indigo)
    }
}

struct ThirdScreen: View {
    
    var body: some View {
        VStack {
            Text("#3")
                .font(.system(size: 200))
            Divider()
            NavStackPop(destination: .previous) {
                Text("Pop to #2")
                    .padding()
                    .background(Color.teal)
            }
            NavStackPop(destination: .root) {
                Text("Pop to Root")
                    .padding()
                    .background(Color.teal)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.pink)
    }
}

struct ScreenSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        ScreenSwitcher()
    }
}
