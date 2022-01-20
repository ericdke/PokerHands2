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
    
    var cardWidth: CGFloat {
        proxy.size.width * 0.055
    }
    
    var body: some View {
        ScrollView {
            List {
                ForEach(model.results) { result in
                    HStack {
                        VStack {
                            HStack {
                                ForEach(result.winnerHoleCardsFileNames, id: \.self) { fn in
                                    Image(fn)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: cardWidth)
                                }
                            }
                            
                            Text(result.winnerName)
                            Text("")
                                .hidden()
                        }
                        
                        Spacer()
                        
                        VStack {
                            HStack {
                                ForEach(result.tableCardsFileNames, id: \.self) { fn in
                                    Image(fn)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: cardWidth)
                                }
                            }
                            
                            Text("\(result.winnerName) wins with \(result.winnerHandName)")
                            Text(result.winnerHandDescription)
                        }
                        
                        Spacer()
                        
                        VStack {
                            HStack {
                                ForEach(result.opponentHoleCardsFileNames, id: \.self) { fn in
                                    Image(fn)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: cardWidth)
                                }
                            }
                            
                            Text(result.opponentName)
                            Text("")
                                .hidden()
                        }
                    }
                    .font(.system(.body, design: .monospaced))
                    .padding(.vertical)
                }
            }
            .frame(height: proxy.size.height - 30)
            
            if !model.results.isEmpty {
                Spacer()
            }
        }
        .padding(.horizontal)
        .opacity(model.results.isEmpty ? 0 : 1)
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
