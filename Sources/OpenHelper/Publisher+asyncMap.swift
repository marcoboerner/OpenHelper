//
//  File.swift
//
//
//  Created by Marco Boerner on 28.02.23.
//

import Foundation
import Combine

public extension Publisher {

    /// A throwing publisher that transforms all elements from an upstream publisher by using an async transform closure.
    /// Warning: The order of execution (FIFO) is only with `maxPublishers = .max(1)` guaranteed.
    func asyncMapThrowing<T>(maxPublishers: Subscribers.Demand = .max(1), _ transform: @escaping (Output) async throws -> T)
    -> Publishers.FlatMap<Future<T, Error>, Publishers.SetFailureType<Self, Error>> {
        flatMap(maxPublishers: maxPublishers) { value in
            Future { promise in
                Task {
                    do {
                        let output = try await transform(value)
                        promise(.success(output))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
    }
}

public extension Publisher {

    /// A publisher that transforms all elements from an upstream publisher by using an async transform closure.
    /// Warning: The order of execution (FIFO) is only with `maxPublishers = .max(1)` guaranteed.
    func asyncMap<T>(maxPublishers: Subscribers.Demand = .max(1), _ transform: @escaping (Output) async -> T)
    -> AnyPublisher<T, Failure> {
        flatMap(maxPublishers: maxPublishers) { value -> Future<T, Failure> in
            Future { promise in
                Task {
                    let result = await transform(value)
                    promise(.success(result))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
