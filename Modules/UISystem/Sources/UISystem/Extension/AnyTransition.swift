//
//  AnyTransition.swift
//  
//
//  Created by Сергей Смирнов on 30/7/23.
//

import SwiftUI

public extension AnyTransition {
    
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading).combined(with: .opacity)
        let removal = AnyTransition.scale.combined(with: .opacity)
        return asymmetric(insertion: insertion, removal: removal)
    }
    
}
