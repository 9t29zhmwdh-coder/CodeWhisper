import Foundation

final class OllamaProvider: LLMProvider, @unchecked Sendable {
    private let underlying: OpenAICompatibleProvider

    init(
        model: String = "llama3.2",
        host: String = "localhost",
        port: Int = 11434,
        temperature: Double? = nil,
        maxTokens: Int? = nil
    ) {
        let url = URL(string: "http://\(host):\(port)")!
        self.underlying = OpenAICompatibleProvider(
            modelName: model,
            baseURL: url,
            temperature: temperature,
            maxTokens: maxTokens
        )
    }

    func chat(messages: [ChatMessage]) async throws -> String {
        try await underlying.chat(messages: messages)
    }
}
