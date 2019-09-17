//
//  main.swift
//  GPIO
//
//  Created by JurjDev on Today.
//

#if os(Linux)
import Glibc
#else
import Darwin.C
#endif
import SwiftyGPIO
import Foundation

let byeMessage = "BYE 👋"

func run() {
    
    print("Hellow, world!")

    if CommandLine.argc < 2 {
        
        print("No Arguments Detected")
            
        print("Input device: ")
        print("Press P for 🍇 RaspberryPi")
        print("Press O for 🍊 OrangePi")
        if let input = readLine() {
            
            print(input)
            validateDeviceInput(input)
        } else {
            
            print(byeMessage)
        }
        
    } else {
        let arguments = CommandLine.arguments
        
        validateDeviceInput(arguments[1])
    }
}

func validateDeviceInput(_ input: String) {
    
    switch input.lowercased() {
    case "p":
        print("Selected 🍇 RaspberryPi")
        
        gpiosForBoard(.RaspberryPi3)
    case "o":
        print("Selected 🍊 OrangePi")
        
        gpiosForBoard(.OrangePi)
        
    default:
        print(byeMessage)
    }
}

func gpiosForBoard(_ board: SupportedBoard) {
    
    switch board {
    case .RaspberryPi3,
         .OrangePi:
        
        guard let ledGPIO = SwiftyGPIO.GPIOs(for: board)[.P4]
            else { fatalError("It has not been possible to initialized the Led Pin GPIO") }
        
        print("🔆")
        let led = Led(ledGPIO: ledGPIO)
        led.blink()
        
        guard let buttonGPIO = SwiftyGPIO.GPIOs(for: board)[.P25]
            else { fatalError("It has not been possible to initialized the button Pin GPIO") }
        buttonGPIO.bounceTime = 0.5
        buttonGPIO.direction = .IN
        
        print("🔘 Press Button to toggle Lights 🔆")
        
        print("⚠️ Press [CTRL + C] to Exit")
        buttonGPIO.onRaising({ _ in led.ledGPIO.toggle() })
        
        while true { }
    
    default:
        print("Not Implemented 🤪")
        print(byeMessage)
    }
}

run()
