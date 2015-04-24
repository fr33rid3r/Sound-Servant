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
  
    override func viewDidLoad() {
        super.viewDidLoad()

        let connectTimer : NSTimer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: Selector("myPerformeCode:"), userInfo: nil, repeats: false)
      
      let disconnectTimer : NSTimer = NSTimer.scheduledTimerWithTimeInterval(8, target: self, selector: Selector("DisconnectCode:"), userInfo: nil, repeats: false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func myPerformeCode(timer : NSTimer) {
  
      // here code to perform
      println("It WORKS!!!")
      self.title = "CONNECTED!"
      disconnectButton.enabled = true
      reconnectButton.enabled = false
}

  func DisconnectCode(timer : NSTimer) {
    
    // here code to perform
   
    self.title = "NOT CONNECTED!"
    disconnectButton.enabled = false
    reconnectButton.enabled = true
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
