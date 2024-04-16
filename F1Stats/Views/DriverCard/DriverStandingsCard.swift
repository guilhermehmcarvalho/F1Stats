//
//  DriverStandingsCard.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 16/04/2024.
//

import SwiftUI

struct DriverStandingsCard: View {
    
  let standingLists: [StandingsList]

  var body: some View {
    ScrollView {
      VStack {
        title("Standings")
          .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
        
        VStack(alignment: .leading) {
          HStack(alignment: .firstTextBaseline) {
            Text("Pos")
              .typography(type: .body(color: .F1Stats.appDark))
              .frame(width: 30)
            Text("Wins")
              .typography(type: .body(color: .F1Stats.appDark))
              .frame(width: 50)
            Text("Points")
              .typography(type: .body(color: .F1Stats.appDark))
              .frame(width: 50)
            Text("Team")
              .typography(type: .body(color: .F1Stats.appDark))
            Spacer()
            Text("Season")
              .typography(type: .body(color: .F1Stats.appDark))
          }
          
          ForEach(standingLists, id: \.season) { season in
            if let standing = season.driverStandings?.first {
              HStack {
                Text(standing.position)
                  .typography(type: .small(color: .F1Stats.appDark))
                  .frame(width: 30)
                Text(standing.wins)
                  .typography(type: .small(color: .F1Stats.appDark))
                  .frame(width: 50)
                Text(standing.points)
                  .typography(type: .small(color: .F1Stats.appDark))
                  .frame(width: 50)
                Text(standing.constructorsAppended)
                  .typography(type: .small(color: .F1Stats.appDark))
                Spacer()
                Text(season.season)
                  .typography(type: .small(color: .F1Stats.appDark))

              }
              .padding(.vertical(2))
            }
          }
        }
        .padding(16)
      }
      .background(Color.F1Stats.appWhite)
      .overlay(
        RoundedRectangle(cornerRadius: 16)
          .stroke(Color.F1Stats.appWhite, lineWidth: 16)
      )
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.F1Stats.primary, lineWidth: 4)
          .padding(8)
      )
      .overlay(
        Color.F1Stats.appYellow.opacity(0.1)
      )
    }
  }

  func title(_ title: String) -> some View {
    ZStack {
      Color.F1Stats.primary

      Text(title)
        .textCase(.uppercase)
        .typography(type: .heading(color: .F1Stats.appWhite))
        .padding(.all(4))
        .multilineTextAlignment(.center)
    }
    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
  }
}


#Preview {
  DriverCardView(viewModel: DriverCardViewModel(driver: DriverModel.stub,
                                            wikipediaApi: WikipediaAPIStub(delay: 1),
                                            driverApi: APIDriversStub(delay: 1)))
}