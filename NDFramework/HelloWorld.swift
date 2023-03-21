//
//  HelloWorld.swift
//  Sample Framework
//
//  Created by Xuân Linh on 17/03/2023.
//

import Foundation
import CryptoKit
import UIKit
public class NDFunctionold{
    public init(){
        
    }
    public func printMessage(mess:String){
        print(mess)
    }
    
    public func Sum(valueX: Int,valueY:Int) -> Int{
        return valueX*valueY
    }
    
    public func Cheklicense(key: String){
        let bundleId = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
        //let value = MD5(string: bundleId!)
        let value = bundleId!
        if (key==value){
            print("ĐÚNG LICENSE")
        }else {
            showErrorAlert()
        }
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
