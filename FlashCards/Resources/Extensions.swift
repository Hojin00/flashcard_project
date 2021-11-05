//
//  Extensions.swift
//  FlashCards
//
//  Created by Hojin Ryu on 27/10/21.
//


import Foundation
import CloudKit
import UIKit
import SwiftUI


extension CKAsset {
    
    func getColor(data: Data) -> Color {
        if let data = NSData(contentsOf: self.fileURL!) {
            do {
                return try Color(NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data as Data)!)
            } catch {
                print(error)
            }
        }
        return Color.clear
    }
}

extension Color {
    
    func colorToData() -> Data {
        do {
            return try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            
        } catch {
            print(error.localizedDescription)
        }
        return Data.init()
    }
    
    func toURL() -> URL? {
        let data = self.colorToData()
        let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
        do {
            try data.write(to: url!)
        } catch let e as NSError {
            print("Error! \(e)");
        }
        return url
    }
}


extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
