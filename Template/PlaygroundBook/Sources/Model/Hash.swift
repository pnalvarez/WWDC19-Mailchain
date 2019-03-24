//
//  Hash.swift
//  Book_Sources
//
//  Created by Pedro Alvarez on 16/03/19.
//

import Foundation

public class Hash{
    
    public static func hash(_ str: String) -> String{
        return String(str.sha256().prefix(10))
    }
    
    public static func hash(_ str: String, _ nonce: UInt) -> String{
        
         let str2 = str + String(nonce)
         return hash(str2)
    }
    
    public static func hash(_ str: String, _ nonce: UInt, _ previousHash: String) -> String{
        
        let str2 = str + String(nonce) + previousHash
        return hash(str2)
    }
}

