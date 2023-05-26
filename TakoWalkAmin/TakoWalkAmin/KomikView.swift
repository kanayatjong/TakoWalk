//
//  KomikView.swift
//  TakoWalkAmin
//
//  Created by Kanaya Tio on 25/05/23.
//

import SwiftUI

struct KomikView: View {
    @State var navigate = false
    var body: some View {
        
        NavigationStack{
            Image("KOMIK TAKOWLK")
                .resizable()
                .ignoresSafeArea()
                .onAppear(){
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 7) { [self] in
                        navigate = true
                    }
                }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigate){
            InGameView()
                .environmentObject(healthKitViewModel)
        }
    }
}

struct KomikView_Previews: PreviewProvider {
    static var previews: some View {
        KomikView()
    }
}
