//
//  main.swift
//  CarSharing
//
//  Created by Яна Латышева on 19.05.2023.
//

import UIKit

/// If we have a TestingAppDelegate (i.e. we're running unit tests),
/// use that to avoid executing initialisation code in AppDelegate
let appDelegateClass: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

UIApplicationMain(CommandLine.argc,
                  CommandLine.unsafeArgv,
                  nil,
                  NSStringFromClass(appDelegateClass))
