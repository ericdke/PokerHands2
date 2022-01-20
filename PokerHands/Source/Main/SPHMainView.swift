//
//  MainView.swift
//  PokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import SwiftUI

struct SPHMainView: View {
    
    @EnvironmentObject var model: SPHDemoModel

    var width: CGFloat {
        200
    }
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                SPHSidebar(width: width)

                SPHEventsView(proxy: proxy)
            }
            .environmentObject(model)
            .padding()
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
