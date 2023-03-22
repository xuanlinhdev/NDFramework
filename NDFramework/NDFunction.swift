//
//  NDFunction.swift
//  NDFramework
//
//  Created by Xuân Linh on 21/03/2023.
//

import Foundation
import UIKit
public class NDFunction{
    public init(){
        
    }
    public func Cheklicense(){
        let bundleId = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
        fetchResult(bundleID: bundleId!)
    }
    
    func fetchResult(bundleID:String) {
        var item = ResponseModel()
        let url = URL(string: "https://api.dauchanviet.com/api/v2/CheckLicense?id="+bundleID+"&platform=IOS")!
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
            // check if response is okay
            guard let data = data else {
                print("invalid response")
                return
            }
            // chuyen Json sang Array
            do {
                item = try JSONDecoder().decode(ResponseModel.self, from: data)
                DispatchQueue.main.async {
                    // Thực hiện các hoạt động trên main thread
                    if (item.success) {
                        self.ShowAler(message: item.message)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }).resume()
    }
    
    func ShowAler(message:String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)

            if let viewController = UIApplication.shared.windows.first?.rootViewController {
                viewController.present(alert, animated: true, completion: nil)
            }
    }
}
class ResponseModel: Codable, Identifiable {
        var success: Bool = true
        var message: String = ""
    }
