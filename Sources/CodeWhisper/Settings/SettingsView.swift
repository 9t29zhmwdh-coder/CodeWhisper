import SwiftUI

struct SettingsView: View {
    @ObservedObject private var model = SettingsModel.shared

    @State private var claudeKey: String  = ""
    @State private var openAIKey: String  = ""
    @State private var mistralKey: String = ""
    @State private var showNewPreset = false
    @State private var newPresetName = ""
    @State private var newPresetPrompt = ""

    var body: some View {
        TabView {
            providerTab
                .tabItem { Label("Provider", systemImage: "cpu") }
            outputTab
                .tabItem { Label("Output", systemImage: "square.and.arrow.up") }
            presetsTab
                .tabItem { Label("Presets", systemImage: "text.badge.star") }
        }
        .padding(16)
        .frame(width: 520, height: 400)
        .onAppear { loadKeys() }
    }

    // MARK: — Provider tab

    private var providerTab: some View {
        Form {
            Picker("Provider", selection: $model.activeProvider) {
                ForEach(SettingsModel.Provider.allCases, id: \.self) { p in
                    Text(p.rawValue).tag(p)
                }
            }

            Divider()

            switch model.activeProvider {
            case .claude:
                TextField("Claude Model", text: $model.claudeModel)
                SecureField("API Key", text: $claudeKey)
                    .onChange(of: claudeKey) { _, new in model.claudeAPIKey = new }

            case .openai:
                TextField("OpenAI Model", text: $model.openAIModel)
                SecureField("API Key", text: $openAIKey)
                    .onChange(of: openAIKey) { _, new in model.openAIAPIKey = new }

            case .mistral:
                TextField("Mistral Model", text: $model.mistralModel)
                SecureField("API Key", text: $mistralKey)
                    .onChange(of: mistralKey) { _, new in model.mistralAPIKey = new }

            case .ollama:
                TextField("Model name", text: $model.ollamaModel)
                HStack {
                    TextField("Host", text: $model.ollamaHost)
                    TextField("Port", value: $model.ollamaPort, formatter: NumberFormatter())
                        .frame(width: 70)
                }

            case .llamaCpp:
                TextField("Model name", text: $model.llamaCppModel)
                HStack {
                    TextField("Host", text: $model.llamaCppHost)
                    TextField("Port", value: $model.llamaCppPort, formatter: NumberFormatter())
                        .frame(width: 70)
                }
            }

            Divider()

            HStack {
                Text("Max Tokens")
                TextField("", value: $model.maxTokens, formatter: NumberFormatter())
                    .frame(width: 80)
            }
            HStack {
                Text("Temperature")
                Slider(value: $model.temperature, in: 0...2, step: 0.05)
                Text(String(format: "%.2f", model.temperature))
                    .frame(width: 40)
            }
        }
    }

    // MARK: — Output tab

    private var outputTab: some View {
        Form {
            Picker("Output Mode", selection: $model.outputMode) {
                ForEach(OutputMode.allCases, id: \.self) { m in
                    Text(m.rawValue).tag(m)
                }
            }
            .pickerStyle(.radioGroup)
        }
    }

    // MARK: — Presets tab

    private var presetsTab: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Custom prompt for \"Custom\" preset:")
                .font(.headline)
            TextEditor(text: $model.customSystemPrompt)
                .frame(height: 80)
                .border(Color.secondary.opacity(0.4))

            Divider()

            Text("Saved Custom Presets:")
                .font(.headline)

            List {
                ForEach(model.customPresets) { preset in
                    VStack(alignment: .leading) {
                        Text(preset.name).bold()
                        Text(preset.systemPrompt)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                }
                .onDelete { idx in model.customPresets.remove(atOffsets: idx) }
            }
            .frame(height: 120)

            if showNewPreset {
                GroupBox {
                    VStack(alignment: .leading, spacing: 6) {
                        TextField("Name", text: $newPresetName)
                        TextEditor(text: $newPresetPrompt)
                            .frame(height: 60)
                            .border(Color.secondary.opacity(0.4))
                        HStack {
                            Button("Add") {
                                guard !newPresetName.isEmpty else { return }
                                model.customPresets.append(
                                    CustomPreset(id: UUID(), name: newPresetName, systemPrompt: newPresetPrompt)
                                )
                                newPresetName = ""; newPresetPrompt = ""; showNewPreset = false
                            }
                            Button("Cancel") { showNewPreset = false }
                        }
                    }
                }
            } else {
                Button("+ New Preset") { showNewPreset = true }
            }
        }
        .padding(8)
    }

    private func loadKeys() {
        claudeKey  = model.claudeAPIKey
        openAIKey  = model.openAIAPIKey
        mistralKey = model.mistralAPIKey
    }
}
