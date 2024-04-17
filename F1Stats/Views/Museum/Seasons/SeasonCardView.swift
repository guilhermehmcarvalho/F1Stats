//
//  SeasonCard.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 16/04/2024.
//

import SwiftUI

struct SeasonCardView: View {

  @ObservedObject var viewModel: SeasonCardViewModel

  var body: some View {
    VStack {
      SeasonMainCardView(viewModel: viewModel.wikipediaViewModel)
        .padding(.all(16))
        .scalingTransition()

      SeasonDriverStandingsCardView(viewModel: viewModel.seasonDriverStandingsViewModel)
        .padding(.all(16))
        .scalingTransition()

      SeasonConstructorStandingsCardView(viewModel: viewModel.seasonConstructorStandingsViewModel)
        .padding(.all(16))
        .scalingTransition()
    }
    .safeAreaPadding(.top)
  }
}

#Preview {
  SeasonCardView(viewModel: SeasonCardViewModel(season: SeasonModel(season: "1989", url: "https://en.wikipedia.org/wiki/2021_Formula_One_World_Championship"),
                                                wikipediaApi: WikipediaAPIStub(),
                                                apiSeason: APISeasonsStub()))
}
