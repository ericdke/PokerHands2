//
//  MainView.swift
//  PokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import SwiftUI
import TexasPokerHands

struct SPHMainView: View {
    
    @State var player1Name: String = ""
    @State var player2Name: String = ""
    @State var numberOfRoundsLabel: String = "" {
        didSet {
            numberOfRounds = Int(numberOfRoundsLabel) ?? 100
        }
    }
    @State var numberOfRounds: Int = 100
    
    var p1name: String {
        player1Name.isEmpty ? "Annette" : player1Name
    }
    
    var p2name: String {
        player2Name.isEmpty ? "Johnny" : player2Name
    }
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Player 1")
                        
                        TextField("enter name", text: $player1Name)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Player 2")
                        
                        TextField("enter name", text: $player2Name)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Rounds")
                        
                        HStack {
                            TextField("100", text: $numberOfRoundsLabel)
                            
                            Button("Go") {
                                // do it
                            }
                        }
                    }
                    .padding()
                    
                    VStack {
                        // random or custom cards
                    }
                    
                    Spacer()
                    
                    VStack {
                        VStack {
                            Text(p1name)
                            
                            Text("000")
                        }
                        .padding()
                        
                        VStack {
                            Text(p2name)
                            
                            Text("000")
                        }
                        .padding()
                    }
                }
                .frame(width: proxy.size.width * 0.2)
                
                // ---
                
                VStack {
                    Text("TODO list view of played hands")
                    
                    
                }
                .padding()
            }
            .padding()
        }
    }
}

struct SPHMainView_Previews: PreviewProvider {
    static var previews: some View {
        SPHMainView()
    }
}
