//
//  Blockchain.swift
//  Book_Sources
//
//  Created by Pedro Alvarez on 16/03/19.
//

import Foundation

public class Blockchain{
    
    var chain: [Block] = []
    var currentDifficulty: UInt = 1
    
    var size: Int{
        return chain.count
    }
    
    init(){
        chain.append(Block.getGenesis())
    }
    
    func setDifficulty(difficulty: UInt){
        currentDifficulty = difficulty
    }
    
    func addBlock(message: String){
        let lastBlock = chain[size - 1]
        let block = Block(message: message, previousHash: lastBlock.hashResult, difficulty: currentDifficulty)
        block.mine()
    }
    
    func isValidChain() -> Bool{
        
        if(chain[0].hashResult != Block.getGenesis().hashResult){
            return false
        }
        
        for i in 1...chain.count{
            let block = chain[i]
            let lastBlock = chain[i-1]
            
            if(block.previousHash != lastBlock.hashResult){
                return false
            }
        }
        return true
    }
    
}
