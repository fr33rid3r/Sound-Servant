//
//  Phone.swift
//  SwiftPhone
//
//  Created by Devin Rader on 1/30/15.
//  Copyright (c) 2015 Devin Rader. All rights reserved.
//

import Foundation

let SPDefaultClientName:String = "jenny";
let SPBaseCapabilityTokenUrl:String = "http://example.com/generateToken?%@"
let SPTwiMLAppSid:String = "APxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

public class Phone {
    var device:TCDevice? = nil
    var connection:TCConnection? = nil
    
    func login() {
    
        //TwilioClient.sharedInstance().setLogLevel(.LOG_VERBOSE);
        
        var url:String = self.getCapabilityTokenUrl()
        
        var swiftRequest = SwiftRequest();
        swiftRequest.get(url, callback: { (err, response, body) -> () in
            if (err != nil) {
                return
            }
            
            //var token = body as! NSString
            
            var token = "eyJhbGciOiAiSFMyNTYiLCAidHlwIjogIkpXVCJ9.eyJpc3MiOiAiQUM2MTVmNTc2MjRkNjE1MDM2NzA1NWIzOGZhYmQxNWZlMiIsICJzY29wZSI6ICJzY29wZTpjbGllbnQ6b3V0Z29pbmc_YXBwUGFyYW1zPUNvbmdyZWdhdGlvbk5hbWUlM0RGaW5jaGxleSZhcHBTaWQ9QVA0ODBiNTg3ZGI2ZTFmZjQyZDllMzZlMDZiODVjNzMxZCIsICJleHAiOiAxNDMwMDA0MTIwfQ.tJ90dld7_juRALXXz4IXLsqIexQR30f1kWzj4tgAda4"
            
            println(token);
            
            if (err == nil && token != "")
            {
                if ( self.device == nil )
                {
                    self.device = TCDevice(capabilityToken: token as String, delegate: nil);
                }
                else
                {
                    self.device!.updateCapabilityToken(token as String);
                }
            }
            else if ( err != nil && response != nil) {
                // We received and error with a response
            }
            else if (err != nil) {
                // We received an error without a response
            }
        });
    }
    
    func getCapabilityTokenUrl() -> String {
        
        var querystring:String = String();
        
        querystring += String(format:"&sid=%@", SPTwiMLAppSid);
        querystring += String(format:"&name=%@", SPDefaultClientName);

        return String(format:SPBaseCapabilityTokenUrl, querystring);
    }

func connect(params dictParams:Dictionary<String,String> = Dictionary<String,String>()) {
    
    if (!self.capabilityTokenValid())
    {
        self.login();
    }
    
    self.connection = self.device?.connect(dictParams, delegate: nil);
}

func capabilityTokenValid()->(Bool) {
    var isValid:Bool = false;
    
    if (self.device != nil) {
        var capabilities = self.device!.capabilities as NSDictionary;
        
        var expirationTimeObject:NSNumber = capabilities.objectForKey("expiration") as! NSNumber;
        var expirationTimeValue:Int64 = expirationTimeObject.longLongValue;
        var currentTimeValue:NSTimeInterval = NSDate().timeIntervalSince1970;
        
        if( (expirationTimeValue-Int64(currentTimeValue)) > 0 ) {
            isValid = true;
        }
    }
    
    return isValid;
}
}