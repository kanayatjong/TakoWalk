//
//  TokoView.swift
//  TakoWalkAmin
//
//  Created by Kanaya Tio on 22/05/23.
//

import SwiftUI


struct TokoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var navigate: Bool = false
    @EnvironmentObject var vm: HealthKitViewModel
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("Toko BG")
                    .resizable()
                    .ignoresSafeArea()
                Image("kali2")
                    .resizable()
                    .frame(width: 119, height: 181)
                    .ignoresSafeArea()
                    .position(x:100, y: 320)
                Image("kali4")
                    .resizable()
                    .frame(width: 119, height: 180)
                    .ignoresSafeArea()
                    .position(x:284, y: 320)
                Image("beli")
                    .resizable()
                    .frame(width: 69, height: 28)
                    .ignoresSafeArea()
                    .position(x:284, y: 440)
                Image("beli")
                    .resizable()
                    .frame(width: 69, height: 28)
                    .ignoresSafeArea()
                    .position(x:100, y: 440)
                Text("\(vm.coin)")
                    .font(.system(size: 15, design: .rounded))
                    .foregroundColor(Color("BROWN"))
                    .fontWeight(.heavy)
                    .position(x: 55, y: 48)
                
                Button{
                    navigate = true
//                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("tutup")
                    .resizable().frame(width: 42.15, height: 40.99)
                } .position(x:356, y: 49)
                
            }
            .navigationDestination(isPresented: $navigate) {
                InGameView().environmentObject(vm)
            }
        } .navigationBarBackButtonHidden(true)
    }
}

struct TokoView_Previews: PreviewProvider {
    static var previews: some View {
        TokoView()
    }
}
