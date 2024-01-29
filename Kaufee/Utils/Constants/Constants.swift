//
//  Constants.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 17.12.23.
//

import iOS_Backend_SDK
import RealmSwift


struct K {
    
    struct App {
        static let bundleID = "com.example.app"
        static let googleClientID = "1086144161327-91ai50psd3ajp03jaofed58enlhog012.apps.googleusercontent.com"
        static let assetServerUrl = "https://wellsavor.com"
        static let backendUrl = "http://localhost:8080"
    }
    
    struct Template {
        static let business = Business(_id: "65b2c541bccb5be91e0d7d78",
                                       userId: "65b2c541bccb5be91e0d7d8f",
                                       photo: "",
                                       name: "Template business",
                                       description: "Enim diam vulputate ut pharetra sit amet aliquam id diam maecenas ultricies mi eget mauris pharetra et ultrices neque ornare",
                                       products: [],
                                       metadata: .init(creation: "7 January")
        )
    }
    
}
