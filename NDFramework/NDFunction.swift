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
    public func Cheklicense(key: String){
        let bundleId = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
        fetchResult(bundleID: bundleId!)
        
    }
    
    func fetchResult(bundleID:String) {
        let url = URL(string: "https://api.dauchanviet.com/api/v2/CheckLicense?id="+bundleID+"&platform=IOS")!
        var urlRequest: URLRequest = URLRequest(url: url)
                       urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { [self] (data, response, error) in
                           // check if response is okay
                           guard let data = data else {
                               print("invalid response")
                               return
                           }
                           if let jsonString = String(data: data, encoding: .utf8) {
                               print(jsonString)
                           }

                           // chuyen Json sang Array
                           do {
                               let item = try JSONDecoder().decode(ResponseModel.self, from: data)
                               if item.success {
                                   showErrorAlert()
                               }
                               
                           } catch {
                               print(error.localizedDescription)
                           }
                           
                       }).resume()
      }
    
    func showErrorAlert() {
        let alertController = UIAlertController(title: "Cảnh báo", message: "Vi phạm bản quyền của NINA", preferredStyle: .alert)
        let alertActionOk = UIAlertAction(title: "Đóng", style: .default) { (act) in
                    //action khi nhấn nút OK
                }
        alertController.addAction(alertActionOk)
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        //...
        rootViewController?.present(alertController, animated: true, completion: nil)

    }
}
class ResponseModel: Codable, Identifiable {
        var success: Bool = true
        var message: String? = ""
    }
