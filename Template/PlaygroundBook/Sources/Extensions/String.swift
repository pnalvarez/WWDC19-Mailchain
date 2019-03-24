//
//  String.swift
//  Book_Sources
//
//  Created by Pedro Alvarez on 17/03/19.
//

import Foundation
import CommonCrypto
import AVFoundation

extension String {
    
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
    
    public func createSoundPlayer() -> AVAudioPlayer?{
        
        let path = Bundle.main.path(forResource: self, ofType: nil)
        let url = URL(fileURLWithPath: path!)
        
        do{
            let soundEffect = try AVAudioPlayer(contentsOf: url)
            return soundEffect
        }
        catch{
            return nil
        }
    }
    
}
