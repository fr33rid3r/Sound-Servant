//
//  ConnectionViewController.swift
//  Sound Servant
//
//  Created by Andrew Greaney on 23/04/2015.
//  Copyright (c) 2015 Andrew Greaney. All rights reserved.
//

import UIKit

class ConnectionViewController: UIViewController {
    
    @IBOutlet weak var reconnectButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var phone:Phone = Phone()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let connectTimer : NSTimer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: Selector("connectCode:"), userInfo: nil, repeats: false)
        
        //let disconnectTimer : NSTimer = NSTimer.scheduledTimerWithTimeInterval(8, target: self, selector: Selector("disconnectCode:"), userInfo: nil, repeats: false)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func connectCode(timer : NSTimer) {
  self.phone.login()
//      statusLabel.text = "Connected!"
//      disconnectButton.enabled = true
//      reconnectButton.enabled = false
}

  func disconnectCode(timer : NSTimer) {
   
//    statusLabel.text = "Not connected!"
//    disconnectButton.enabled = false
//    reconnectButton.enabled = true
  }


    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
