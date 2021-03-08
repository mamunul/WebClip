//
//  WebClipGenerator.swift
//  WebClip
//
//  Created by Mamunul Mazid on 3/8/21.
//

import Foundation
import UIKit

struct Shortcut {
    var iconImage: UIImage
    var iconLabel: String
    var url: String
    var bundleID: String
    var shortcutUUID: String
}

class WebClipGenerator {
    var shortcutArray = [Shortcut]()

    init() {
        loadShortcuts()
    }

    func loadShortcuts() {
        let shortcut1 =
            Shortcut(
                iconImage: UIImage(named: "icon.png")!,
                iconLabel: "instagram",
                url: "instagram://",
                bundleID: "com.burbn.instagram",
                shortcutUUID: UUID().uuidString
            )

        let shortcut2 =
            Shortcut(
                iconImage: UIImage(named: "icon2.png")!,
                iconLabel: "Maps",
                url: "maps://",
                bundleID: "com.apple.maps",
                shortcutUUID: UUID().uuidString
            )

        shortcutArray.append(shortcut1)
        shortcutArray.append(shortcut2)
    }

    func generate() {
        var payloadArray = [PayloadContent]()

        for shortcut in shortcutArray {
            let iconData = shortcut.iconImage.pngData()
            let payloadContent =
                PayloadContent(
                    FullScreen: true,
                    Icon: iconData!,
                    IgnoreManifestScope: false,
                    IsRemovable: true,
                    Label: shortcut.iconLabel,
                    PayloadDescription: "Configures settings for a web clip",
                    PayloadDisplayName: "\(shortcut.iconLabel) Icon",
                    PayloadIdentifier: "com.apple.webClip.managed.\(shortcut.shortcutUUID)",
                    PayloadType: "com.apple.webClip.managed",
                    PayloadUUID: shortcut.shortcutUUID,
                    PayloadVersion: 1,
                    Precomposed: false,
                    TargetApplicationBundleIdentifier: shortcut.bundleID,
                    URL: shortcut.url
                )

            payloadArray.append(payloadContent)
        }

        let uuid = UUID().uuidString

        let webclip =
            WebClip(
                PayloadContent: payloadArray,
                PayloadDisplayName: "Paradox Icons",
                PayloadIdentifier: uuid,
                PayloadRemovalDisallowed: false,
                PayloadType: "Configuration",
                PayloadUUID: uuid,
                PayloadVersion: 1)

        let pe = PropertyListEncoder()
        pe.outputFormat = .xml
        do {
            let p = try pe.encode(webclip)
            let filename = getDocumentsDirectory().appendingPathComponent("ParadoxIcons.mobileconfig")
            try p.write(to: filename)

            print(filename)
        } catch {
            print(error)
        }
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct PayloadContent: Codable {
    var FullScreen: Bool
    var Icon: Data
    var IgnoreManifestScope: Bool
    var IsRemovable: Bool
    var Label: String
    var PayloadDescription: String
    var PayloadDisplayName: String
    var PayloadIdentifier: String
    var PayloadType: String
    var PayloadUUID: String
    var PayloadVersion: Int
    var Precomposed: Bool
    var TargetApplicationBundleIdentifier: String
    var URL: String
}

struct WebClip: Codable {
    var PayloadContent: [PayloadContent]
    var PayloadDisplayName: String
    var PayloadIdentifier: String
    var PayloadRemovalDisallowed: Bool
    var PayloadType: String
    var PayloadUUID: String
    var PayloadVersion: Int
}
