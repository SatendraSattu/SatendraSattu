//
//  Data.swift
//  flightTime
//
//  Created by Satendra Pal Singh on 14/02/1943 Saka.
//

import Foundation
struct Data : Codable{
    var from : String
    var arrival : String
    var to : String
    var flight_number : String
    var departure : String
    var duration : String
    var instructions : String
    var stops : Int
    var airline : AirLine
    
    struct AirLine : Codable {
        var id : Int
        var name : String
        var logo : String
    }
}
    

    
    

