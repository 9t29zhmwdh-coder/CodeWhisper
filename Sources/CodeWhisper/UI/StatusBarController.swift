import AppKit
import SwiftUI

@MainActor
final class StatusBarController {
    private var statusItem: NSStatusItem!
    private var settingsWindowController: NSWindowController?

    init() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "chevron.left.forwardslash.chevron.right",
                                   accessibilityDescription: "CodeWhisper")
        }
        buildMenu()
    }

    private func buildMenu() {
        let menu = NSMenu()

        let title = NSMenuItem(title: "CodeWhisper", action: nil, keyEquivalent: "")
        title.isEnabled = false
        menu.addItem(title)
        menu.addItem(.separator())

        menu.addItem(NSMenuItem(title: "Settings…", action: #selector(openSettings), keyEquivalent: ",")
            .then { $0.target = self })

        menu.addItem(.separator())

        menu.addItem(NSMenuItem(title: "Quit CodeWhisper", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        statusItem.menu = menu
    }

    @objc private func openSettings() {
        if let wc = settingsWindowController {
            wc.window?.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }

        let view = NSHostingView(rootView: SettingsHostView())
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 520, height: 420),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        window.title = "CodeWhisper Settings"
        window.contentView = view
        window.center()

        let wc = NSWindowController(window: window)
        wc.showWindow(nil)
        NSApp.activate(ignoringOtherApps: true)
        settingsWindowController = wc
    }
}

// Wrapper so SettingsView can be closed via the window's red button
private struct SettingsHostView: View {
    var body: some View {
        SettingsView()
    }
}

private extension NSMenuItem {
    func then(_ block: (NSMenuItem) -> Void) -> NSMenuItem {
        block(self)
        return self
    }
}
