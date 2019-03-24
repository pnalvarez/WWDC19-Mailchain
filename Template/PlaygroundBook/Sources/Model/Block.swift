//
//  Block.swift
//  Book_Sources
//
//  Created by Pedro Alvarez on 16/03/19.
//

import Foundation

public class Block{
    
    public var message: String = ""
    public var nonce: UInt = 0
    public var previousHash: String = ""
    public var difficulty: UInt = 1
    
    public var hashResult: String{
        
        return Hash.hash(message, nonce, previousHash)
    }
    
    public init(message: String, nonce: UInt, previousHash: String, difficulty: UInt){
        self.message = message
        self.nonce = nonce
        self.difficulty = difficulty
        self.previousHash = previousHash
    }
    
    public init(message: String, previousHash: String, difficulty: UInt){
        self.message = message
        self.difficulty = difficulty
        self.previousHash = previousHash
    }
    
    public func mine(){
        
        while(hashResult.last != "0"){
            nonce += 1
            print("Hash = \(hashResult)")
        }
    }
    
    public func mineStep() -> Block{
        
        nonce += 1
        return self
    }
    
    public static func getGenesis() -> Block{
        return Block(message: "Genesis Message", previousHash: "", difficulty: 1)
    }
    
    
}
