//
//  CreateChallengeViewModel.swift
//  Increment
//
//  Created by Lusine on 5/20/22.
//

import SwiftUI
import Combine

typealias UserId = String

final class CreateChallengeViewModel: ObservableObject {
    
    @Published var exerciseDropdown = ChallengePartViewModel(type: .exercise)
    @Published var increaseDropdown = ChallengePartViewModel(type: .increase)
    @Published var lengthDropdown = ChallengePartViewModel(type: .length)
    @Published var startAmountDropdown = ChallengePartViewModel(type: .startAmount)
    
    @Published var error: IncrementError?
    @Published var isLoading = false
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    
    private var cancellables: [AnyCancellable] = []
    
    enum Action {
       case createChallenge
    }
  
    init(userService: UserServiceProtocol = UserService(),
         challengeService: ChallengeServiceProtocol = ChalengeService()) {
        self.userService = userService
        self.challengeService = challengeService
    }
    
    func send(action: Action) {
        switch action {
            case .createChallenge:
                isLoading = true
                currentUserId().flatMap { userId -> AnyPublisher<Void, IncrementError> in
                    return self.createChallenge(userId: userId)
                }.sink { completion in
                    self.isLoading = false
                    switch completion {
                        case let .failure(error):
                            self.error = error
                        case .finished:
                            print("Finished")
                    }
                } receiveValue: { _ in
                    print("success")
                    
                }.store(in: &cancellables)

        }
    }
    
    private func createChallenge(userId: UserId) -> AnyPublisher<Void, IncrementError> {
        guard let exercise = exerciseDropdown.text,
              let startAmount = startAmountDropdown.number,
              let increase = increaseDropdown.number,
              let length = lengthDropdown.number else {
        
             return   Fail(error: .default(description: "Parsing error")).eraseToAnyPublisher()
        }

        let challenge = Challenge(exercise: exercise,
                                  startAmount: startAmount,
                                  increase: increase,
                                  length: length,
                                  userId: userId,
                                  startDate: Date()
        )
        
        return challengeService.create(challenge).eraseToAnyPublisher()
    }
    
    
    private func currentUserId() -> AnyPublisher<UserId, IncrementError> {

        return userService.currentUserPublisher().flatMap { user -> AnyPublisher<UserId, IncrementError> in
            
            return Fail(error: .auth(description: "Some firebase auth error")).eraseToAnyPublisher()
            print("user is logged in")
            if let userId = user?.uid {

                return Just(userId)
                    .setFailureType(to: IncrementError.self)
                    .eraseToAnyPublisher()
            } else {
                print("user is lbeing logged in anonymously...")
            return self.userService
                    .signInAnonymously()
                    .map { $0.uid }
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
            
        }
    }
    

extension CreateChallengeViewModel {
    struct  ChallengePartViewModel: DropDownItemProtocol {
        var selectedOption: DropDownOption
        
        var options: [DropDownOption]
        
        var headerTittle: String {
            type.rawValue
        }
        
        var dropDownTittle: String {
            selectedOption.formatted
            }
        
        
        var isSelected: Bool = false
        
        private let type: ChallengePartType
        
        init(type: ChallengePartType) {
            switch type {
                case .exercise:
                    self.options =  ExerciseOption.allCases.map {$0 .toDropDoownOption}
                case .startAmount:
                    self.options = StartOption.allCases.map {$0 .toDropDoownOption}
                case .increase:
                    self.options = IncreaseOption.allCases.map {$0 .toDropDoownOption}
                case .length:
                    self.options = LengthOption.allCases.map {$0 .toDropDoownOption}
            }
            self.type = type
            self.selectedOption = options.first!
        }
        
        enum ChallengePartType: String, CaseIterable {
            case exercise = "Exercise"
            case startAmount = "Starting Amount"
            case increase = "Daily Increase"
            case length = "Challenge Length"
        }
        
        enum ExerciseOption: String, CaseIterable, DropDownOptionProtocol {
            case pullups
            case pushups
            case situps
            
            var toDropDoownOption: DropDownOption {
                .init(type: .text(rawValue),
                      formatted: rawValue.capitalized
                )
            }
            
        }
        
        enum StartOption: Int, CaseIterable, DropDownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropDoownOption: DropDownOption {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue)"
              )
            }
        }
        
        enum IncreaseOption: Int, CaseIterable, DropDownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropDoownOption: DropDownOption {
                .init(type: .number(rawValue),
                      formatted: "+\(rawValue)"
             )
            }
        }
        
        enum LengthOption: Int,CaseIterable, DropDownOptionProtocol {
            case seven = 7, Fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropDoownOption: DropDownOption {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue) days"
                )
            }
        }
    }
}

extension CreateChallengeViewModel.ChallengePartViewModel {
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
    
    var number: Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        return nil
    }
}
