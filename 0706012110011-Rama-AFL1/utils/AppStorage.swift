//
//  AppStorageUtil.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 01/03/23.
//

import Foundation


struct AppStorageUtils {
    static func location() -> URL {
        
        guard let appSupportURL = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {
            fatalError("Unable to get Application Support directory.")
        }
        
        return URL(
            fileURLWithPath: appSupportURL.appending(
                path:"0706012110011-Rama-AFL1",
                directoryHint: URL.DirectoryHint.isDirectory)
            .path
        )
       
    }
    
    
}
