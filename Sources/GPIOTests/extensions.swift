//
//  extensions.swift
//  GPIOTests
//
//  Created by JurjDev on 9/16/19.
//

#if os(Linux)
import Glibc
#else
import Darwin.C
#endif
import SwiftyGPIO

extension GPIO {
    enum GPIOState: Int {
        case on = 1
        case off = 0
    }
    
    var gpioState: GPIOState? {
        get { return GPIOState(rawValue: self.value) }
        set { self.value = newValue?.rawValue ?? 0 }
    }
    
    func toggle() {
        gpioState = gpioState == .off ? .on : .off
    }
}
