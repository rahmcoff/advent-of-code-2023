//
//  TestDay20.swift
//  TestDay20
//
//  Created by Peter of the Norse on 12/19/23.
//

import XCTest

final class TestDay20: XCTestCase {
    let inputA = """
    broadcaster -> a, b, c
    %a -> b
    %b -> c
    %c -> inv
    &inv -> a
    """
    
    let inputB = """
    broadcaster -> a
    %a -> inv, con
    &inv -> b
    %b -> con
    &con -> output
    """
    
    func testPart1A() {
        let net = Network(inputA)
        net.pushTestButton()
        XCTAssertEqual(net.isBackToBeginning(), true)
        XCTAssertEqual(net.pulseCount(pushes: 1000), 32000000)
    }

    func testPart1B() {
        let net = Network(inputB)
        XCTAssertEqual(net.pushTestButton(), [true, false])
        XCTAssertEqual(net.isBackToBeginning(), false)
        XCTAssertEqual(net.pushTestButton(), [true])
        XCTAssertEqual(net.isBackToBeginning(), false)
        XCTAssertEqual(net.pushTestButton(), [false, true])
        XCTAssertEqual(net.isBackToBeginning(), false)
        XCTAssertEqual(net.pushTestButton(), [true])
        XCTAssertEqual(net.isBackToBeginning(), true)
        XCTAssertEqual(net.pulseCount(pushes: 1000), 11687500)
    }
}
