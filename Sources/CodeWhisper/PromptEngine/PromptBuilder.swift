import Foundation

enum PromptBuilder {
    static func build(preset: PromptPreset, code: String, customPrompt: String? = nil) -> [ChatMessage] {
        let systemText = preset == .custom ? (customPrompt ?? "") : preset.systemPrompt
        let system = ChatMessage.system(systemText)
        let user   = ChatMessage.user(code)
        return [system, user]
    }

    static func build(systemPrompt: String, code: String) -> [ChatMessage] {
        [
            .system(systemPrompt),
            .user(code),
        ]
    }
}
