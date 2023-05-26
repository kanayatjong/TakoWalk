//
//  DailyHistoryView.swift
//  TakoWalkAmin
//
//  Created by Kanaya Tio on 24/05/23.
//

import SwiftUI

struct DailyHistoryView: View {
    @EnvironmentObject var vm: HealthKitViewModel
    @State var navigate: Bool = false
    
    var body: some View {
        NavigationStack{
            
            ZStack{
                Image("history bg")
                    .resizable()
                    .ignoresSafeArea()
                
                Image("cointainer isi history")
                    .resizable().frame(width: 337, height: 106.7)
                    .ignoresSafeArea()
                    .position(x:194, y:246)
                
                Text("\(vm.userStepCount)")
                    .font(.system(size: 40, design: .rounded))
                    .foregroundColor(Color("kuning"))
                .fontWeight(.heavy)
                .position(x: 284 , y: 256)
                .shadow(radius: 2)
                .shadow(radius: 2)
                .shadow(radius: 2)
                .shadow(radius: 2)
                .shadow(radius: 2)
                
                Text("\(vm.jumlahRoketKecil)")
                    .font(.system(size: 30, design: .rounded))
                    .foregroundColor(Color("kuning"))
                .fontWeight(.heavy)
                .position(x: 184 , y: 246)
                .shadow(radius: 2)
                .shadow(radius: 2)
                .shadow(radius: 2)
                .shadow(radius: 2)
                .shadow(radius: 2)
                
                Text("\(vm.jumlahRoketBesar)")
                    .font(.system(size: 30, design: .rounded))
                    .foregroundColor(Color("kuning"))
                .fontWeight(.heavy)
                .position(x: 110 , y: 246)
                .shadow(radius: 2)
                .shadow(radius: 2)
                .shadow(radius: 2)
                .shadow(radius: 2)
                .shadow(radius: 2)
                
                Button{
                    navigate = true
                } label: {
                    Image("tutup")
                    .resizable().frame(width: 42.15, height: 40.99)
                } .position(x:356, y: 49)
                
                Text("\(vm.getDate())")
                    .font(.system(size: 20, design: .rounded))
                    .foregroundColor(Color("cream"))
                .fontWeight(.heavy)
                .position(x: 104 , y: 192)
                .shadow(radius: 2)
                .shadow(radius: 2)
                .shadow(radius: 2)
                .shadow(radius: 2)
                .shadow(radius: 2)
                
               
            }
            .navigationDestination(isPresented: $navigate) {
                InGameView().environmentObject(vm)
            }

        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct DailyHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        DailyHistoryView()
    }
}
