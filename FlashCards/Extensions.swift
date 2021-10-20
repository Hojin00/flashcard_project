//
//  Extensions.swift
//  FlashCards
//
//  Created by Lucca Molon on 18/10/21.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
