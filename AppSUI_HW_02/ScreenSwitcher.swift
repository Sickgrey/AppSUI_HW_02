//
//  ScreenSwitcher.swift
//  AppSUI_HW_02
//
//  Created by Сергей Смирнов on 30/7/23.
//

import SwiftUI

struct ScreenSwitcher: View {
    
    var pickerOptions = ["Apple", "Tesla", "NASA"]
    @State var pickerVariant = 0
    
    var body: some View {
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
        }
    }
}

struct ScreenSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        ScreenSwitcher()
    }
}
