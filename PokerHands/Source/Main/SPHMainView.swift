//
//  MainView.swift
//  PokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import SwiftUI

struct SPHMainView: View {
    
    @EnvironmentObject var model: SPHDemoModel
    @State var width: CGFloat = 220
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                
                SPHSidebar(width: width)
                    
                
                // ---
                
                VStack {
                    Text("TODO list view of played hands")
                    
                    
                }
                .padding()
            }
            .environmentObject(model)
            .padding()
            .onAppear {
                _ = model.playOneHandAllIn()
            }
        }
    }
}

struct SPHMainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SPHMainView()
                .environmentObject(SPHDemoModel())
                .previewDevice(PreviewDevice(rawValue: "macos"))
        }
    }
}
