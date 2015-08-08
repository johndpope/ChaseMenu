//
//  AppDelegate.swift
//  ChaseMenu
//
//  Created by John Pope on 20/07/2015.
//  Copyright © 2015 Fieldstorm. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        let listVC:ListVC = ListVC(window: window)
        window.becomeFirstResponder()
        window.contentView.addSubview(listVC.view)
        
     
    }
    
    

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}
