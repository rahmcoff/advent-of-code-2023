//
//  TestDay19.swift
//  TestDay19
//
//  Created by Peter of the Norse on 12/18/23.
//

import XCTest

final class TestDay19: XCTestCase {
    let systemInput = """
    px{a<2006:qkq,m>2090:A,rfg}
    pv{a>1716:R,A}
    lnx{m>1548:A,A}
    rfg{s<537:gd,x>2440:R,A}
    qs{s>3448:A,lnx}
    qkq{x<1416:A,crn}
    crn{x>2662:A,R}
    in{s<1351:px,qqz}
    qqz{s>2770:qs,m<1801:hdj,R}
    gd{a>3333:R,R}
    hdj{m>838:A,pv}
    """
    
    let partsInput = """
    {x=787,m=2655,a=1222,s=2876}
    {x=1679,m=44,a=2067,s=496}
    {x=2036,m=264,a=79,s=2244}
    {x=2461,m=1339,a=466,s=291}
    {x=2127,m=1623,a=2188,s=1013}
    """
    
    func testPart1() throws {
        let sys = System(systemInput)
        XCTAssertEqual(sys.test([.x: 787, .m: 2655, .a: 1222, .s: 2876]), true)
        XCTAssertEqual(sys.test([.x: 1679, .m: 44, .a: 2067, .s: 496]), false)
        XCTAssertEqual(sys.test([.x: 2036, .m: 264, .a: 79, .s: 2244]), true)
        XCTAssertEqual(sys.test([.x: 2461, .m: 1339, .a: 466, .s: 291]), false)
        XCTAssertEqual(sys.test([.x: 2127, .m: 1623, .a: 2188, .s: 1013]), true)

        let parts = Part.parse(partsInput)
//        XCTAssert(parts[0].values.reduce(0, +), 7540)
        XCTAssertEqual(parts.filter({ sys.test($0) }).map({ $0.values.reduce(0, +) }).reduce(0, +), 19114)
    }

    func testPart2() {
        let sys = System(systemInput)
        print(sys.getPossibleDistinctParts())
    }
}
