//
//  LedBehavior.swift
//  GPIOTests
//
//  Created by JurjDev on 9/16/19.
//

#if os(Linux)
import Glibc
#else
import Darwin.C
#endif
import Foundation
import SwiftyGPIO

//MARK: -Led

public struct Led {
    
    let ledGPIO: GPIO
    
    init(ledGPIO: GPIO) {
        self.ledGPIO = ledGPIO
        self.ledGPIO.direction = .OUT
    }
    
    //MARK: - Private
    private func ledSleep(_ duration: TimeInterval) {
        let durationInSeconds = UInt32(round(duration))
        sleep(durationInSeconds)
    }
    
    //MARK: - Actions
    
    func blink() {
        ledGPIO.gpioState = .off
        ledSleep(1.0)
        ledGPIO.gpioState = .on
        ledSleep(1.0)
        ledGPIO.gpioState = .off
    }
    
    func blink(duration: TimeInterval) {
        while true {
            ledGPIO.toggle()
            ledSleep(duration)
        }
    }
}
