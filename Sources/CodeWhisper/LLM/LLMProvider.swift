import Foundation

protocol LLMProvider: Sendable {
    func chat(messages: [ChatMessage]) async throws -> String
}

enum LLMError: LocalizedError, Sendable {
    case invalidURL(String)
    case httpError(statusCode: Int, body: String)
    case decodingError(underlying: Error)
    case timeout
    case noAPIKey

    var errorDescription: String? {
        switch self {
        case .invalidURL(let u):      return "Invalid URL: \(u)"
        case .httpError(let c, let b): return "HTTP \(c): \(b.prefix(200))"
        case .decodingError(let e):   return "Decode error: \(e.localizedDescription)"
        case .timeout:                return "Request timed out"
        case .noAPIKey:               return "No API key configured. Open Settings to add one."
        }
    }
}
