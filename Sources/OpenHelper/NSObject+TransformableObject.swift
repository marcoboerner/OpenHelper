//
//  TransformableObject.swift
//  OpenHelper
//
//  Created by Marco Boerner on 25.02.22.
//

import Foundation

public protocol TransformableObject where Self: AnyObject {
    associatedtype T: AnyObject
    @discardableResult func set(_ transformation: (T) -> Void) -> T
}

public extension TransformableObject {
    @discardableResult
    func set(_ transformation: (Self) -> Void) -> Self {
        transformation(self)
        return self
    }
}

extension NSObject: TransformableObject { }
