//
//  SPHSidebar.swift
//  PokerHands
//
//  Created by Eric Dejonckheere on 20/01/2022.
//

import SwiftUI
import TexasPokerHands

struct SPHSidebar: View {
    
    @EnvironmentObject var model: SPHDemoModel
    var width: CGFloat
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Player 1")
                
                TextField("enter name", text: $model.player1Name)
            }
            .padding()
            .background(Color.blue)
            
            VStack(alignment: .leading) {
                Text("Player 2")
                
                TextField("enter name", text: $model.player2Name)
            }
            .padding()
            .background(Color.pink)
            
            VStack(alignment: .leading) {
                Text("Rounds")
                
                HStack {
                    TextField("10", text: $model.numberOfRoundsLabel)
                    
                    Button("Go") {
                        model.playHandsAllIn(player1: TPHPlayer(name: model.player1Name), player2: TPHPlayer(name: model.player2Name))
                    }
                    .background(Color.green)
                    .disabled(!model.gameIsEnabled)
                }
            }
            .padding()
            .background(Color.purple)
            
            VStack {
                // random or custom cards
            }
            
            Spacer()
            
            VStack {
                VStack {
                    Text(model.p1name)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .padding(.bottom)
                        .frame(width: width)
                    
                    Text("\(model.player1Score) wins")
                }
                .padding(.vertical)
                .background(Color.blue)

                VStack {
                    Text(model.p2name)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .padding(.bottom)
                        .frame(width: width)
                    
                    Text("\(model.player2Score) wins")
                }
                .padding(.vertical)
                .background(Color.pink)
            }
            .font(.title)
        }
        .frame(width: width)
    }
}

struct SPHSidebar_Previews: PreviewProvider {
    static var previews: some View {
        SPHSidebar(width: 220).environmentObject(SPHDemoModel())
    }
}
