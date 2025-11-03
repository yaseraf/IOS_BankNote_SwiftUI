//
//  JailBreakDetector.swift
//  QSC
//
//  Created by FIT on 15/04/2025.
//  Copyright © 2025 FIT. All rights reserved.
//

import Foundation
import UIKit
import Darwin
import MachO

class JailbreakDetector {
    static func isJailbroken() -> Bool {
        #if targetEnvironment(simulator)
        return false
        #else
        let fileManager = FileManager.default

        let jailbreakPaths = [
            // Jailbreak apps and tools
            "/Applications/Cydia.app",
            "/Applications/Sileo.app",
            "/Applications/Zebra.app",
            "/Applications/FakeCarrier.app",
            "/Applications/Icy.app",
            "/Applications/IntelliScreen.app",
            "/Applications/MxTube.app",
            "/Applications/RockApp.app",

            // Package managers and tweaks
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/usr/libexec/cydia",
            "/usr/bin/sshd",
            "/usr/sbin/sshd",
            "/usr/libexec/ssh-keysign",
            "/etc/apt",
            "/private/var/lib/apt/",
            "/private/var/cache/apt/",
            "/var/lib/cydia",
            "/var/log/syslog",
            
            // Rootless / Dopamine hints
            "/var/jb",
            "/private/var/jb",
            "/private/var/tmp/cydia.log",
            "/private/var/mobile/Library/Preferences/com.coolstar.sileo.plist",
            "/var/mobile/Documents/CrackerXI+", // piracy tweaks
            "/usr/lib/libhooker.dylib",

            // Shell and other binaries
            "/bin/bash",
            "/bin/sh",
            "/usr/bin/ssh",
            "/usr/bin/apt",
            "/usr/bin/scp",
            "/sbin/mount",
            "/etc/ssh/sshd_config"
        ]

        for path in jailbreakPaths {
            if fileManager.fileExists(atPath: path) {
                return true
            }
        }

        // Can we write outside the sandbox?
        let testPath = "/private/" + UUID().uuidString
        do {
            try "test".write(toFile: testPath, atomically: true, encoding: .utf8)
            try fileManager.removeItem(atPath: testPath)
            return true
        } catch {}
        
        // We check for dynamic libraries
        for i in 0..<_dyld_image_count() {
            if let cName = _dyld_get_image_name(i) {
                let name = String(cString: cName)
                if name.contains("Tweak") || name.contains("Substrate") || name.contains("libhooker") || name.contains("Libsubstrate") {
                    print("Suspicious dynamic library loaded: \(name)")
                    return true
                }
            }
        }
        
        // Check if You Can Access Other App Containers
        if FileManager.default.fileExists(atPath: "/User/Applications/") {
            return true
        } else {
            return false
        }
        
        #endif
    }
}
