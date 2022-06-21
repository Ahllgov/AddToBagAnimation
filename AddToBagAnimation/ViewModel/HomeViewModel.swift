//
//  HomeViewModel.swift
//  AddToBagAnimation
//
//  Created by Магомед Ахильгов on 21.06.2022.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var showCart = false
    @Published var selectedSize = ""
    
    @Published var startAnimation = false
    @Published var shoesAnimation = false
    @Published var endAnimation = false
    
    @Published var showBag = false
    @Published var saveCart = false
    
    @Published var addItemToCart = false
    
    @Published var cartItem = 0
    
    
    func performingAnimations() {
        withAnimation(.easeInOut(duration: 0.8)) {
            shoesAnimation.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation(.easeInOut) {
                self.showBag.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.showCart.toggle()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            self.addItemToCart.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.endAnimation.toggle()
            }
        }
    }
    
    func resetAll() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
            withAnimation {
                showCart.toggle()
            }
            
            startAnimation = false
            endAnimation = false
            selectedSize = ""
            addItemToCart = false
            showCart = false
            shoesAnimation = false
            saveCart = false
            cartItem += 1
        }
    }
}
