//
//  AddToCartView.swift
//  AddToBagAnimation
//
//  Created by Магомед Ахильгов on 23.06.2022.
//

import SwiftUI

struct AddToCartView: View {
    
    @EnvironmentObject var homeData: HomeViewModel
    
    var animation: Namespace.ID
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                
                if !homeData.startAnimation {
                    Image("shoes")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "SHOE", in: animation)
                        .padding(-25)
                }
                
                VStack(alignment: .trailing, spacing: 10) {
                    Text("Air Force 1 07 Mid LV8")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                    
                    Text("$350.00")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
            }
            .padding(50)
            
            Divider()
            
            Text("SELECT SIZE")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 15) {
                ForEach(sizes, id: \.self) { size in
                    Button {
                        withAnimation {
                            homeData.selectedSize = size
                        }
                    } label: {
                        Text(size)
                            .fontWeight(.semibold)
                            .foregroundColor(homeData.selectedSize == size ? .white : .black)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(homeData.selectedSize == size ? .orange : .black.opacity(0.06))
                            .cornerRadius(10)
                    }

                }
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.7)) {
                    homeData.startAnimation.toggle()
                }
            } label: {
                Text("Add to cart")
                    .fontWeight(.bold)
                    .foregroundColor(homeData.selectedSize == "" ? .black : .white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(homeData.selectedSize == "" ? Color.black.opacity(0.06) : Color.orange)
                    .cornerRadius(18)
            }
            .disabled(homeData.selectedSize == "")
            .padding(.top)
        }
        .padding()
        .background(Color.white.clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 35)))
    }
}

let sizes = ["EU 40","EU 41","EU 42","EU 43","EU 44","EU 45","EU 46"]

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

struct AddToCartView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
