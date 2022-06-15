//
//  QuerySnapShotPublishers.swift
//  Increment
//
//  Created by Lusine on 5/21/22.
//
//
import Combine
import  Firebase
import FirebaseFirestore

extension Publishers {
    struct QuerySnapShotPublisher: Publisher {
        typealias Output = QuerySnapshot
        
        typealias Failure = IncrementError
        
        private let query: Query
        
        init(query: Query) {
            self.query = query
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
           let querySnapsotSubscription = QuerySnapshotSubscription(subscriber: subscriber, query: query)
            subscriber.receive(subscription: querySnapsotSubscription)
        }
    }
    
    class QuerySnapshotSubscription<S: Subscriber>: Subscription where S.Input == QuerySnapshot, S.Failure == IncrementError {
        private var subscriber: S?
        private var listener: ListenerRegistration?
        
        init(subscriber: S, query: Query) {
            listener = query.addSnapshotListener { querySnapshot, error in
                if let error = error {
                  subscriber.receive(completion: .failure(.default(description: error.localizedDescription)))
                } else if let querySnapshot = querySnapshot {
                    _ = subscriber.receive(querySnapshot)
                } else {
                    subscriber.receive(completion: .failure(.default()))
                }
            }
        }
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscriber = nil
            listener = nil
        }
        
            
        }
    }

