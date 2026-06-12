import Foundation

enum OutputMode: String, CaseIterable, Codable, Sendable {
    case popup       = "Popup Window"
    case clipboard   = "Copy to Clipboard"
    case notification = "macOS Notification"
    case pasteBack   = "Paste Back into Editor"
}
