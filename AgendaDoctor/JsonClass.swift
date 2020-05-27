//
//  JsonClass.swift
//  AgendaDoctor
//
//  Created by alex on 17/05/20.
//  Copyright © 2020 TecNM. All rights reserved.
//

import Foundation
import UIKit

class JsonClass: NSObject {
let urlBase = "http://192.168.1.67/"
    let key = "123456abcde"
    let model = UIDevice.current.model
    let iddevice = UIDevice.current.identifierForVendor!.uuidString
    let langStr = Locale.current.languageCode!
    let fecha = "2020-01-01"
    func arrayFromJson(url:String,datos_enviados:NSMutableDictionary, comletionHandler: @escaping (NSArray?) -> Void){
        
                let url = URL(string: "\(urlBase)/\(url)")!
                var request = URLRequest(url: url)
            
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
                request.httpMethod = "POST"
                request.httpBody = try! JSONSerialization.data(withJSONObject: datos_enviados)
            
            
                let task = URLSession.shared.dataTask(with: request) { datos_recibidos, response, error in
                    if error != nil{
                        comletionHandler(nil)
                    }
                    else{
                        do {
                            print("datos recibidos: \(String(describing: String(data: datos_recibidos!, encoding: .utf8))) - datos enviados: \(datos_enviados)")
                            if let array = try JSONSerialization.jsonObject(with: datos_recibidos!) as? NSArray {
                                comletionHandler(array)
                            }
                        } catch let parseError {
    
                            print("error servidor PHP \(String(data: datos_recibidos!, encoding: .utf8)) \(parseError)")
                            //detectamos un error y devolvemos el array vacío
                            comletionHandler(nil)
                        }
                    }
                }
                task.resume()
    }
    
}
