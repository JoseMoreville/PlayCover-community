//
//  installer.swift
//  PlayCover
//
//  Created by José Elias Moreno villegas on 17/10/22.
//

import Foundation
import ArgumentParser

@main
struct PlayCoverCLI: ParsableCommand {
    @Argument()
    var ipaPath: String
    func run() throws {
        print(ipaPath)
        // installApp(ipa: ipaPath)
    }
}

let arguments = CommandLine.arguments

func exitWithoutResult() -> Never {
    print("null")
    exit(0)
}

func installApp(ipa: String) {
    guard let ipaUrl = URL(string: ipa) else { return }
    Installer.install(ipaUrl: ipaUrl, returnCompletion: { _ in
        DispatchQueue.main.async {
            NotifyService.shared.notify(
                NSLocalizedString("notification.appInstalled", comment: ""),
                NSLocalizedString("notification.appInstalled.message", comment: ""))
        }
    })
}
