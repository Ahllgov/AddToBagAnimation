//
//  Home.swift
//  AddToBagAnimation
//
//  Created by Магомед Ахильгов on 20.06.2022.
//

import SwiftUI

struct Home: View {
    
    @StateObject var homeData = HomeViewModel()
    
    @Namespace var animation
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 15) {
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "rectangle.3.offgrid.fill")
                            .font(.title2)
                            .foregroundColor(.black)
                    }

                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "bag.fill")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(.purple)
                            .clipShape(Circle())
                            .overlay(
                                Text("\(homeData.cartItem)")
                                    .font(.caption.bold())
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.orange)
                                    .clipShape(Circle())
                                    .offset(x: 15, y: -10)
                                    .opacity(homeData.cartItem != 0 ? 1 : 0)
                            )
                    }
                }
                .overlay(
                    Text("Nike")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                )
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Air Force 1 07 Mid LV8")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        
                        Text("Nike")
                            .font(.title2.bold())
                            .foregroundColor(.black)
                            
                        Image("shoes")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                        
                        Text("Price")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            
                        Text("$350.00")
                            .font(.title2.bold())
                            .foregroundColor(.orange)
                    }
                    .padding()
                    .background(.black.opacity(0.06))
                    .cornerRadius(10)
                    .padding()
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            homeData.showCart.toggle()
                        }
                    }
                }
            }
            .blur(radius: homeData.showCart ? 50 : 0)
            
            AddToCart(animation: animation)
                .offset(y: homeData.showCart ? homeData.startAnimation ? 500 : 0 : 500)
                .environmentObject(homeData)
            
            if homeData.startAnimation {
                VStack {
                    Spacer()
                    
                    ZStack {
                        
                        Color.white
                            .frame(width: homeData.shoesAnimation ? 100 : getRect().width * 1.3, height: homeData.shoesAnimation ? 100 : getRect().width * 1.3)
                            .clipShape(Circle())
                            .opacity(homeData.shoesAnimation ? 1 : 0)
                        
                        Image("shoes")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: "SHOE", in: animation)
                            .padding(-25)
                            .frame(width: 80, height: 80)
                    }
                    .offset(y: homeData.showCart ? 70 : -120)
                    .scaleEffect(homeData.saveCart ? 0.6 : 1)
                    .onAppear(perform: homeData.performingAnimations)
                    
                    if !homeData.saveCart {
                        Spacer()
                    }
                    
                    Image(systemName: "bag\(homeData.addItemToCart ? ".fill" : "")")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(homeData.addItemToCart ? Color.purple : Color.orange)
                        .clipShape(Circle())
                        .offset(y: homeData.showBag ? -50 : 300)
                }
                .frame(width: getRect().width)
                .offset(y: homeData.endAnimation ? 500 : 0)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color.black.opacity(0.04).ignoresSafeArea())
        .onChange(of: homeData.endAnimation) { value in
            if homeData.endAnimation {
                homeData.resetAll()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct AddToCart: View {
    
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
