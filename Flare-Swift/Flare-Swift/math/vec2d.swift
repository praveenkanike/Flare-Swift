//
//  vec2d.swift
//  Flare-Swift
//
//  Created by Umberto Sonnino on 2/12/19.
//  Copyright © 2019 2Dimensions. All rights reserved.
//

import Foundation

class Vec2D: Equatable, Hashable {
    var _buffer : [Float32]
    
    var values : [Float32] {
        get {
            return self._buffer
        }
        set {
            self._buffer = newValue
        }
    }
    
    // Overload [] operator for this class
    subscript(index: Int) -> Float32 {
        get {
            return _buffer[index]
        }
        set {
            _buffer[index] = newValue
        }
    }
    
    init() {
        self._buffer = [0.0, 0.0]
    }
    
    init(clone copy: Vec2D) {
        _buffer = copy.values
    }
    
    init(fromValues x: Float32, y: Float32) {
        self._buffer = [x, y]
    }
    
    // Equatable Protocol
    static func == (lhs: Vec2D, rhs: Vec2D) -> Bool {
        guard lhs._buffer.count != rhs._buffer.count else {
            return false
        }
        let lBuf = lhs.values
        let rBuf = rhs.values
        let len = lBuf.count
        for i in 0 ..< len {
            if lBuf[i] != rBuf[i] {
                return false
            }
        }
        return true
    }
    
    // Hashable Protocol
    func hash(into hasher: inout Hasher) {
        for f in _buffer {
            hasher.combine(f)
        }
    }
    
    static func copy(_ o: Vec2D, _ a: Vec2D) {
        o[0] = a[0]
        o[1] = a[1]
    }
    
    static func transformMat2D(_ o: Vec2D, _ a: Vec2D, _ m: Mat2D) -> Vec2D {
        let x = a[0]
        let y = a[1]
        o[0] = m[0] * x + m[2] * y + m[4]
        o[1] = m[1] * x + m[3] * y + m[5]
        return o
    }
    
    static func transformMat2(_ o: Vec2D, _ a: Vec2D, _ m: Mat2D) -> Vec2D {
        let x = a[0]
        let y = a[1]
        o[0] = m[0] * x + m[2] * y
        o[1] = m[1] * x + m[3] * y
        return o
    }
    
    static func subtract(_ o: Vec2D, _ a: Vec2D, _ b: Vec2D) -> Vec2D {
        o[0] = a[0] - b[0]
        o[1] = a[1] - b[1]
        return o
    }
    
    static func add(_ o: Vec2D, _ a: Vec2D, _ b: Vec2D) -> Vec2D {
        o[0] = a[0] + b[0]
        o[1] = a[1] + b[1]
        return o
    }
    
    static func scale(_ o: Vec2D, _ a: Vec2D, _ scale: Float32) -> Vec2D {
        o[0] = a[0] * scale
        o[1] = a[1] * scale
        return o
    }
    
    static func lerp(_ o: Vec2D, _ a: Vec2D, _ b: Vec2D, _ f: Float32) -> Vec2D {
        let ax = a[0]
        let ay = a[1]
        o[0] = ax + f * (b[0] - ax)
        o[1] = ay + f * (b[1] - ay)
        return o
    }
    
    static func length(_ a: Vec2D) -> Float32 {
        let x = a[0]
        let y = a[1]
        return sqrt(x * x + y * y)
    }
    
    static func distance(_ a: Vec2D, _ b: Vec2D) -> Float32 {
        let x = b[0] - a[0]
        let y = b[1] - a[1]
        return sqrt(x * x + y * y)
    }
    
    static func negate(_ result: Vec2D, _ a: Vec2D) -> Vec2D {
        result[0] = -a[0]
        result[1] = -a[1]
        return result
    }
    
    static func normalize(_ result: Vec2D, _ a: Vec2D) {
        let x = a[0]
        let y = a[1]
        var len = x * x + y * y
        if (len > 0.0) {
            len = 1.0 / sqrt(len)
            result[0] = a[0] * len
            result[1] = a[1] * len
        }
    }
    
    static func dot(_ a: Vec2D, _ b: Vec2D) -> Float32 {
        return a[0] * b[0] + a[1] * b[1]
    }
    
    static func scaleAndAdd(_ result: Vec2D, _ a: Vec2D, _ b: Vec2D, _ scale: Float32) -> Vec2D {
        result[0] = a[0] + (b[0] * scale)
        result[1] = a[1] + (b[1] * scale)
        return result
    }
}
