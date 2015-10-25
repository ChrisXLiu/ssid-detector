//
//  ViewController.swift
//  SSID Detector
//
//  Created by Xi Liu on 10/24/15.
//  Copyright © 2015 ChrisLiu. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration.CaptiveNetwork

public class SSID {
    class func fetchSSIDInfo() ->  String {
        if let interfaces:CFArray! = CNCopySupportedInterfaces() {
            if interfaces == nil {
                return "Function not supported in Simulator."
            }
            
            for i in 0..<CFArrayGetCount(interfaces){
                let interfaceName: UnsafePointer<Void> = CFArrayGetValueAtIndex(interfaces, i)
                let rec = unsafeBitCast(interfaceName, AnyObject.self)
                let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)")
                if unsafeInterfaceData != nil {
                    let interfaceData = unsafeInterfaceData! as Dictionary!
                    return interfaceData["SSID"] as! String
                }
            }
        }
        return "Not connected to Wifi"
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var ssid: UILabel!
    
    @IBOutlet weak var refresh: UIButton!
    
    func update(button: UIButton) {
        ssid.text = SSID.fetchSSIDInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ssid.text = SSID.fetchSSIDInfo()
        
        refresh.addTarget(self, action: "update:", forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}

