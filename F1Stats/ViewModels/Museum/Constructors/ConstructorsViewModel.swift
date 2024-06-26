//
//  ConstructorsViewModel.swift
//  F1Stats
//
//  Created by Guilherme Carvalho on 05/04/2024.
//

import Foundation
import Combine

class ConstructorsViewModel: ObservableObject {

  private var apiConstructors: APIConstructorsProtocol
  private let wikipediaAPI: WikipediaAPIProtocol

  private var fetchStatusSubject = PassthroughSubject<FetchStatus, Never>()
  private var toastSubject = PassthroughSubject<Toast?, Never>()

  @Published var fetchStatus: FetchStatus = .ready
  @Published var constructorsList: [ConstructorModel] = []
  @Published var errorToast: Toast?

  private var cancellable: AnyCancellable?
  private let itemsPerPage = 30
  private var offset = 0
  private var totalConstructors = 0;
  private var paginationThresholdId: String?

  init(apiConstructors: APIConstructorsProtocol, wikipediaAPI: WikipediaAPIProtocol) {
    self.apiConstructors = apiConstructors
    self.wikipediaAPI = wikipediaAPI

    fetchStatusSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$fetchStatus)
     toastSubject
      .receive(on: DispatchQueue.main)
      .assign(to: &$errorToast)
  }

  func fetchConstructors() {
    cancellable = apiConstructors.listOfAllConstructors(limit: itemsPerPage, offset: offset)
      .observeFetchStatus(with: fetchStatusSubject)
      .assignToastForError(with: toastSubject)
      .receive(on: DispatchQueue.main)
      .sink { _ in } receiveValue: { [weak self] response in
        self?.constructorsList.append(contentsOf: response.table.constructors)
        self?.offset += response.table.constructors.count
        self?.totalConstructors = response.total
        if let self = self {
          var thresholdIndex = self.constructorsList.index(self.constructorsList.endIndex, offsetBy: -5)
          if thresholdIndex < 0 {
            thresholdIndex = 0
          }
          self.paginationThresholdId = constructorsList[thresholdIndex].constructorID
        }

      }
  }

  //MARK: - PAGINATION
  func onItemDisplayed(currentItem item: ConstructorModel){
    if item.constructorID == paginationThresholdId, constructorsList.count < totalConstructors {
      fetchConstructors()
    }
  }
}
