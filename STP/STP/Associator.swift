//
//  Associator.swift
//  STP
//
//  Created by Chris O'Neil on 10/11/15.
//  Copyright © 2015 Because. All rights reserved.
//

import ObjectiveC

// Why lifted?
// Call it ValueWrapper or Wrapper
private final class Lifted<T> {
    let value: T
    init(_ x: T) {
        value = x
    }
}

class Associator {

    static private func lift<T>(x: T) -> Lifted<T>  {
        return Lifted(x)
    }

    static func setAssociatedObject<T>(object: AnyObject, value: T, associativeKey: UnsafePointer<Void>, policy: objc_AssociationPolicy) {
        if let v: AnyObject = value as? AnyObject {
            objc_setAssociatedObject(object, associativeKey, v,  policy)
        }
        else {
            objc_setAssociatedObject(object, associativeKey, lift(value),  policy)
        }
    }

    static func getAssociatedObject<T>(object: AnyObject, associativeKey: UnsafePointer<Void>) -> T? {
        if let v = objc_getAssociatedObject(object, associativeKey) as? T {
            return v
        }
        else if let v = objc_getAssociatedObject(object, associativeKey) as? Lifted<T> {
            return v.value
        }
        else {
            return nil
        }
    }
}