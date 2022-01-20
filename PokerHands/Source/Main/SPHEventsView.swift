//
//  SPHEventsView.swift
//  PokerHands
//
//  Created by Eric Dejonckheere on 20/01/2022.
//

import SwiftUI
import TexasPokerHands

struct SPHEventsView: View {
    
    @EnvironmentObject var model: SPHDemoModel
    var proxy: GeometryProxy
    
    var body: some View {
        ScrollView {
            List {
                ForEach(model.results) { result in
                    HStack {
                        Text(result.winnerName)
                        Text(result.winnerHoleCards)
                        Text(result.winnerHandName)
                    }
                    .font(.system(.body, design: .monospaced))
                }
            }
            .frame(height: proxy.size.height)
        }
    }
}

struct SPHEventsView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { proxy in
            let model = SPHDemoModel()
            SPHEventsView(proxy: proxy)
                .environmentObject(model)
                .previewDevice(PreviewDevice(rawValue: "macos"))
                .onAppear {
                    model.numberOfRounds = 2
                    model.playHandsAllIn(player1: TPHPlayer(name: "yolo"), player2: TPHPlayer(name: "galak"))
                }
        }
        
    }
}
