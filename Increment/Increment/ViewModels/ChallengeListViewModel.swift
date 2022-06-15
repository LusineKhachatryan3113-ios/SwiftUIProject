//
//  ChallengeListViewModel.swift
//  Increment
//
//  Created by Lusine on 5/21/22.
//


import Combine


final class ChallengeListViewModel: ObservableObject {
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables: [AnyCancellable] = []
    @Published private(set) var itemViewModels:[ChallengeItemViewModel] = []
    let title = "Challenges"
    
    enum Action {
        case retry
        case create
    }
    
    
    
    
    init(userService: UserServiceProtocol = UserService(), challengeService: ChallengeServiceProtocol = ChalengeService()
    ){
        self.userService = userService
        self.challengeService = challengeService
        observeChallenges()
    }
    
    func send(action: Action) {
        switch action{
        case .retry:
        observeChallenges()
        case .create: break
           //showingCreateModel = true
    }
    }
    
    
    private func observeChallenges() {
        userService.currentUserPublisher()
            .compactMap { $0?.uid }
            .flatMap { userId -> AnyPublisher<[Challenge], IncrementError> in
                return self.challengeService.observeChallenges(userId: userId)
               
               
            }.sink { completion in
                switch completion {
                    case let .failure(error):
                        print(error.localizedDescription)
                    case .finished:
                        print("finished")
                }
            } receiveValue: { challenges in
                self.itemViewModels = challenges.map{ .init($0) }
               
            }.store(in: &cancellables)
    }
}
