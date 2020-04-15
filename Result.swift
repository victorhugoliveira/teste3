//
//  Result.swift
//  SCalc WatchKit App
//
//  Created by Plinio Vilela on 19/07/19.
//  Copyright © 2019 Plinio Vilela. All rights reserved.
//

import Foundation

extension Formatter {
    static let scientific: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.positiveFormat = "0.###E+0"
        formatter.exponentSymbol = "e"
        return formatter
    }()
}

extension Numeric {
    var scientificFormatted: String {
        return Formatter.scientific.string(for: self) ?? ""
    }
}

class Result{
    var numberStr : String
    var statusStr : String
    
    init(numberStr: String, statusStr: String){
        self.numberStr = numberStr
        self.statusStr = statusStr
    }

    
    private func prepareNumber(numStr : String) -> String{
        var num = numStr
        if numStr.hasSuffix(".0"){
            num = numStr.split(separator: ".").map(String.init).first!
        }
        if(num.count>11){
            return String(Double(numStr)!.scientificFormatted)
        }
        return num
    }

    
    func getNumberToDisplay() -> String {
        if(self.statusStr=="temp"){
            return self.numberStr
        }
        return prepareNumber(numStr : numberStr)
    }
    
    func getStatusToDisplay() -> String {
        if(self.statusStr=="temp"){
            return ""
        }
        return self.statusStr
    }
    
}
