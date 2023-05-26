//
//  InGameView.swift
//  TakoWalkAmin
//
//  Created by Kanaya Tio on 22/05/23.
//

import SwiftUI
import HealthKit
import CoreData

struct InGameView: View {
    @EnvironmentObject var vm: HealthKitViewModel
    @State var isShowingHistory: Bool = false
    @State var isShowingToko: Bool = false
    @State private var rectangleColor = Color("GWEEN")
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack{
                    
                }
                .onAppear{
                    vm.healthRequest()
                }
                
                ZStack{
                    ZStack{
                        Image("TAKOWALK BG")
                            .resizable()
                            .ignoresSafeArea()
                        
                        if vm.roketImg == "ROKET BESAR" {
                            Image("ROKET BESAR")
                                .resizable().frame(width: 176.13, height: 274.04)
//                                .ignoresSafeArea()
                                .position(x:284, y: vm.rocketPositionY)
                                .animation(.easeInOut(duration: 3))
                        } else {
                            Image("ROKET KECIL")
                                .resizable().frame(width: 140, height: 229.5)
//                                .ignoresSafeArea()
                                .position(x:279, y: vm.rocketPositionY)
                                .animation(.easeInOut(duration: 3))
                        }
                        
                        Image("CHARGER ROCKET")
                            .resizable().frame(width: 213.25, height: 184.41)
//                            .ignoresSafeArea()
                            .position(x: 283, y: 482)
                        
                        ZStack{
                            Image("RODAAA")
                                .resizable().frame(width: 115, height: 115)
                                .rotationEffect(vm.rotationAngle)
                                .animation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false))
                                .onAppear {
                                    vm.rotationAngle = .degrees(360)
                                }
                          
                        }   .position(x: 77, y: 560)
                            .ignoresSafeArea()
                        
                        
                        Image("TAKO")
                            .resizable().frame(width: 56.27, height: 63)
//                            .ignoresSafeArea()
                            .position(x: 76, y: 516)
                        ZStack{
                            Image("score")
                                .resizable().frame(width: 127.24, height: 35.71)
//                                .ignoresSafeArea()
                                .position(x: 77, y: 18)
                            
                            Text("Score: \(vm.userStepCount)")
                                .font(.system(size: 15, design: .rounded))
                                .foregroundColor(Color("BROWN"))
                                .fontWeight(.heavy)
                                .position(x: 73, y: 17.5)
                            
                        }
                        
                        ZStack{
                            Image("coin")
                                .resizable().frame(width: 127, height: 35.04)
//                                .ignoresSafeArea()
                                .position(x: 210, y: 18)
                            
                            Text("\(vm.coin)")
                                .font(.system(size: 15, design: .rounded))
                                .foregroundColor(Color("BROWN"))
                                .fontWeight(.heavy)
                                .position(x: 185, y: 17.5)
                        }
                        
                        ZStack (alignment: .leading){
                            
                            ZStack{
                                Rectangle()
                                    .fill(rectangleColor)
                                    .frame(width: 167, height: 28)
                                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                                    .onAppear {
                                        animateColor()
                                        
                                    }
                            }.position(x: 110, y: 117)
                                .ignoresSafeArea()
                            
                            Image("BUTTON ATAS")
                                .resizable().frame(width: 192.47, height: 77.54)
//                                .ignoresSafeArea()
                                .position(x: 110, y: 80)
                            
                            if vm.roketImg == "ROKET BESAR" {
                                Text("MELUNCUR: 1000 LANGKAH")
                                    .font(.system(size: 9, design: .rounded))
                                    .foregroundColor(Color("BROWN"))
                                    .fontWeight(.heavy)
                                    .position(x: 120, y: 101
                                    )
                                
                                Text("\(vm.progressLangkah) / 1.000")
                                    .font(.system(size: 16, design: .rounded))
                                    .foregroundColor(Color("BROWN"))
                                    .fontWeight(.heavy)
                                    .position(x: 116, y: 70)
                                
                            }else if vm.roketImg == "ROKET KECIL" {
                                Text("MELUNCUR: 500 LANGKAH")
                                    .font(.system(size: 9, design: .rounded))
                                    .foregroundColor(Color("BROWN"))
                                    .fontWeight(.heavy)
                                    .position(x: 118, y: 101
                                    )
                            }
                            
                        }
                        
                        ZStack{
                        Image("daily")
                        .resizable()
                        .frame(width: 176, height: 108).position(x: 98, y: 722)
                            
                            
                            let progressDailyMisi = Int(vm.userStepCount)
                            Text("\(4000 - progressDailyMisi!) LANGKAH LAGI")
                                .font(.system(size: 10.5, design: .rounded))
                                .foregroundColor(Color("BROWN"))
                                .fontWeight(.heavy)
                                .position(x: 98, y: 746)
                        }
                        
                    }
                    
                    
                    HStack{
                        Button{
                            isShowingToko = true
                        } label: {
                            Image("toko")
                            .resizable().frame(width: 84.28, height: 89.5)
                        }.position(x: 240, y: 723)
                        
                        Button{
                            isShowingHistory = true
                        } label: {
                            Image("history daily")
                            .resizable().frame(width: 84.28, height: 89.5)
                        }.position(x: 134, y: 723)
                        
                    }
                }
            }
            
            .navigationDestination(isPresented: $isShowingHistory) {
                DailyHistoryView().environmentObject(vm)
            }
            .navigationDestination(isPresented: $isShowingToko) {
                TokoView().environmentObject(vm)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            vm.roketImg = vm.getRocket()
            
            if vm.roketImg == "ROKET BESAR" {
                vm.rocketPositionY = 266
            } else {
                vm.rocketPositionY = 286
            }
            
            vm.startReadingSteps()
        }
    }
    
    private func animateColor() {
        let colors: [Color] = [Color("GWEEN"), Color(" ")]
        var currentIndex = 0
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            withAnimation {
                rectangleColor = colors[currentIndex]
            }
            
            currentIndex = (currentIndex + 1) % colors.count
        }
    }
}

struct InGameView_Previews: PreviewProvider {
    static var previews: some View {
        InGameView()
    }
}
