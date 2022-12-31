//
//  Result.swift
//  DGarciaEcommerce
//
//  Created by MacBookMBA3 on 28/12/22.
//

import Foundation

struct Result {
    var Correct : Bool
    var ErrorMessage : String
    var Ex : Error?
    var Object : Any?
    var Objects : [Any]?
    
    init(Correct: Bool, ErrorMessage: String, Ex: Error, Object: Any? = nil, Objects: [Any]? = nil) {
        self.Correct = Correct
        self.ErrorMessage = ErrorMessage
        self.Ex = Ex
        self.Object = Object
        self.Objects = Objects
    }
    
    init(){
        self.Correct = false
        self.ErrorMessage = ""
        self.Ex = nil
        self.Object = nil
        self.Objects = nil
    }
    
    
}
