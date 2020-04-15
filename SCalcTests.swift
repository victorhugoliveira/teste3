//
//  SCalcTests.swift
//  SCalcTests
//
//  Created by Plinio Vilela on 03/05/19.
//  Copyright © 2019 Plinio Vilela. All rights reserved.
//

import XCTest
//@testable import SCalc

class SCalcTests: XCTestCase {
    var model : Model!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        model = Model()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // 01
    func testPlusOperation_01() {
        // 1. given
        var res = model.treatEvent(event:"2")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"2")
        // 2. when
        res = model.treatEvent(event:"=")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "4", "2+2=4")
    }

    
    // 02
    func testPlusOperation_02() {
        // 1. given
        var res = model.treatEvent(event:"2")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"2")
        // 2. when
        res = model.treatEvent(event:"=")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "25", "23+2=25")
    }
    
    
    // 03
    func testRejectInitialZeros() {
        // 1. given
        var res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        // 2. when
        res = model.treatEvent(event:"0")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "0", "Initial zeros are ignored")
    }
    
    
    // 04
    func testRejectDoublePoints() {
        // 1. given
        var res = model.treatEvent(event:"0")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:".")
        // 2. when
        res = model.treatEvent(event:"1")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "0.01", "Double points are ignored")
    }
    
    
    // 05
    func testRejectDoublePointsSecondNumber() {
        // 1. given
        var res = model.treatEvent(event:"0")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"1")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"1")
        // 2. when
        res = model.treatEvent(event:"=")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "0.02", "Double points are ignored second number too")
    }
    
    
    // 06
    func testRejectDoubleEquals() {
        // 1. given
        var res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"1")
        res = model.treatEvent(event:"2")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"2")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"-")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"=")
        res = model.treatEvent(event:"=")
        // 2. when
        res = model.treatEvent(event:"=")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "11", "Multiple operations, consider the last. Ignore multiple equals.")
    }
    
    
    // 07
    func testAppendAfterAnOperation() {
        // 1. given
        var res = model.treatEvent(event:"1")
        res = model.treatEvent(event:"2")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"-")
        res = model.treatEvent(event:"2")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"=")
        res = model.treatEvent(event:"1")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"1")
        res = model.treatEvent(event:"=")
        // 2. when
        res = model.treatEvent(event:"=")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "1002", "Append to 100 -> 1001 + 1 = 1002.")
    }
    
    // 08
    func testSecondNumberDecimal() {
        // 1. given
        var res = model.treatEvent(event:"1")
        res = model.treatEvent(event:"2")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"-")
        res = model.treatEvent(event:"2")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"1")
        //res = model.treatEvent(event:"=")
        // 2. when
        res = model.treatEvent(event:"=")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "100.7", "Second number is a decimal")
    }
 
    
    // 09
    func testNegativeNumbers() {
        // 1. given
        var res = model.treatEvent(event:"-")
        res = model.treatEvent(event:"2")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"=")
        res = model.treatEvent(event:"-")
        res = model.treatEvent(event:"2")
        res = model.treatEvent(event:"1")
        res = model.treatEvent(event:"=")
        // 2. when
        res = model.treatEvent(event:"=")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "-14", "Resultado negativo")
    }
    
    // 10
    func testLimits() {
        // 1. given
        var res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"1")
        res = model.treatEvent(event:"=")
        // 2. when
        res = model.treatEvent(event:"=")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "10000000000", "Doze digitos, nao aceita...")
    }
    
    // 11
    func testLimitsScientificNotation() {
        // 1. given
        var res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"1")
        // 2. when
        res = model.treatEvent(event:"=")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "1e+11", "Doze digitos, nao aceita...")
    }
        
    // 12
    func testLimitsDecimalPoits() {
        // 1. given
        var res = model.treatEvent(event:"0")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"3")
        // 2. when
        //res = model.treatEvent(event:"=")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "0.0000003", "")
    }
    
    // 13
    func testLimitsScientificNotation_2() {
        // 1. given
        var res = model.treatEvent(event:"1")
        res = model.treatEvent(event:"2")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"4")
        res = model.treatEvent(event:"5")
        res = model.treatEvent(event:"6")
        res = model.treatEvent(event:"7")
        res = model.treatEvent(event:"8")
        res = model.treatEvent(event:"9")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"1")
        // 2. when
        res = model.treatEvent(event:"+")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "12345678901", "Onze digitos, aceita...")
    }
    
    // 14
    func testLimitsDecimalPoits_2() {
        // 1. given
        var res = model.treatEvent(event:"0")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"3")
        // 2. when
        res = model.treatEvent(event:"+")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "0.000000003", "")
    }
    
    // 15
    func testLimitsDecimalPoits_3() {
        // 1. given
        var res = model.treatEvent(event:"0")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"3")
        // 2. when
        res = model.treatEvent(event:"+")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "0.000000006", "")
    }
    
    // 16
    func testLimitsDecimalPoits_4() {
        // 1. given
        var res = model.treatEvent(event:"0")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"3")
        // 2. when
        res = model.treatEvent(event:"=")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "0.000000006", "")
    }
    
    // 17
    func testLimitsDecimalPoits_5() {
        // 1. given
        var res = model.treatEvent(event:"0")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"3")
        // 2. when
        res = model.treatEvent(event:"=")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "3.000000006", "")
    }
    
    
    // 18
    func testLimitsDecimalPoits_6() {
        // 1. given
        var res = model.treatEvent(event:"0")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:".")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"+")
        res = model.treatEvent(event:"3")
        res = model.treatEvent(event:"0")
        res = model.treatEvent(event:"0")
        // 2. when
        res = model.treatEvent(event:"=")
        // 3. then
        XCTAssertEqual(res.getNumberToDisplay(), "3.03e+2", "")
    }
}
