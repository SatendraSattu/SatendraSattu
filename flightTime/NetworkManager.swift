//
//  NetworkManager.swift
//  flightTime
//
//  Created by Satendra Pal Singh on 14/02/1943 Saka.
//

import Foundation
import UIKit
class NetworkManager{
    
    func airLineData(completionHandler: @escaping ([Data]) -> Void) {
        let url = URL(string: "https://api.androidhive.info/json/airline-tickets.php?from=DEL&to=CHE")!

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching films: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(String(describing: response))")
            return
          }

            guard let dataResponse = data,
                      error == nil else {
                      print(error?.localizedDescription ?? "Response Error")
                      return }
                do{
                    //here dataResponse received from a network request
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                                           dataResponse, options: [])
                    print(jsonResponse) //Response result
                    
                    
                    let decoder = JSONDecoder()
                       let model = try decoder.decode([Data].self, from:
                                    dataResponse) //Decode JSON Response Data
                       print(model)
                    completionHandler(model)
                    
                 } catch let parsingError {
                    print("Error", parsingError)
               }
            
            
//          if let data = data,
//             let dataSummary = try? JSONDecoder().decode([Data].self, from: data) {
//            print(data)
//            completionHandler(dataSummary)
//          }
        })
        task.resume()
      }
    
    
    func airLineDataUpdate(data: [Data],completionHandler: @escaping (UpdateData) -> Void) {
        
      
        let str = "https://api.androidhive.info/json/airline-tickets-price.php?flight_number=\(data[0].flight_number)&from=DEL&to=CHE"
      
        print(str)
        let url = URL(string: str)!

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching films: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(String(describing: response))")
            return
          }

            guard let dataResponse = data,
                      error == nil else {
                      print(error?.localizedDescription ?? "Response Error")
                      return }
                do{
                    //here dataResponse received from a network request
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                                           dataResponse, options: [])
                    print(jsonResponse) //Response result
                    
                    
                    let decoder = JSONDecoder()
                       let model = try decoder.decode(UpdateData.self, from:
                                    dataResponse) //Decode JSON Response Data
                       print(model)
                    completionHandler(model)
                    
                 } catch let parsingError {
                    print("Error", parsingError)
               }
            
//          }
        })
        task.resume()
      }
}
