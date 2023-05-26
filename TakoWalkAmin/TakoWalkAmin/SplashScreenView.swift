//
//  SplashScreenView.swift
//  TakoWalkAmin
//
//  Created by Kanaya Tio on 25/05/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State var navigate = false
    var body: some View {
        NavigationStack{
            ZStack{
                Image("bg splash screen tako")
                    .resizable()
                    .ignoresSafeArea()
                    
                Image("gambar splash tako")
                    .resizable().frame(width: 192.88, height: 157.46)
                    .ignoresSafeArea()
                    .offset(y: -8)
            }
            .navigationDestination(isPresented: $navigate){
                KomikView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            playMusic(music: "bg music")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [self] in
                navigate = true
            }
        }
        
    }
    init(){
        UINavigationBar.setAnimationsEnabled(false)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
