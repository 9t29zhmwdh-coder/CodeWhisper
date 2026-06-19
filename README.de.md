<div align="center">
  <img src="RayStudio.png" alt="RayStudio Logo" width="120"/>

  <h1>CodeWhisper</h1>
</div>

[🇬🇧 English Version](README.md)

**macOS AI-Code-Assistent, direkt in Xcode und jeden Texteditor via System-Services integriert.**

Code markieren, Rechtsklick → Services → CodeWhisper: Explain. Fertig.

[![CI](https://github.com/9t29zhmwdh-coder/CodeWhisper/actions/workflows/ci.yml/badge.svg)](https://github.com/9t29zhmwdh-coder/CodeWhisper/actions) ![Apple Silicon](https://img.shields.io/badge/Apple-Silicon-000000?logo=apple&logoColor=white) ![Platform](https://img.shields.io/badge/Platform-macOS-lightgrey?logo=apple&logoColor=black) ![Swift](https://img.shields.io/badge/Swift-F05138?logo=swift&logoColor=white) ![AI | Claude Code](https://img.shields.io/badge/AI-Claude_Code-black?logo=anthropic&logoColor=white) ![AI | Copilot](https://img.shields.io/badge/AI-Copilot-black?logo=github&logoColor=white) ![AI | Ollama](https://img.shields.io/badge/AI-Ollama-black?logo=ollama&logoColor=white)

---

## Funktionen

| Preset | Beschreibung |
|---|---|
| **Explain** | Klare Erklärung des markierten Codes in Prosa |
| **Refactor** | Lesbarkeit und Best Practices verbessern |
| **Optimize** | Performanceoptimiertes Rewrite |
| **Add Comments** | Dokumentations-Kommentare einfügen |
| **Find Bugs** | Bugs und Edge-Cases analysieren |
| **Write Tests** | XCTest Unit Tests generieren |
| **Custom** | Eigener System-Prompt aus den Einstellungen |

### KI-Anbieter

| Anbieter | Hinweise |
|---|---|
| Claude (Anthropic) | Standard: claude-sonnet-4-6 |
| OpenAI | Standard: gpt-4o |
| Mistral | Standard: mistral-large-latest |
| Ollama | Lokal, Host/Port konfigurierbar |
| llama.cpp | Lokal, Host/Port konfigurierbar |

### Ausgabe-Modi

- **Popup-Fenster**: schwebendes Panel mit «Kopieren»- und «Zurückpaste»-Schaltfläche
- **In Zwischenablage kopieren**: lautlos + kurze Benachrichtigung
- **macOS-Benachrichtigung**: im Benachrichtigungszentrum
- **Zurückpaste**: ersetzt den markierten Text im Editor (erfordert Bedienungshilfen-Berechtigung)

---

## Voraussetzungen

- macOS 14 Sonoma oder neuer
- Xcode Command Line Tools (`xcode-select --install`)
- Swift 5.9+

---

## Build & Installation

```bash
git clone https://github.com/9t29zhmwdh-coder/CodeWhisper
cd CodeWhisper
make install
```

`make install` kompiliert den Code, erstellt das `.app`-Bundle, kopiert es nach `/Applications/` und leert den NSServices-Cache.

---

## Erste Einrichtung

1. `/Applications/CodeWhisper.app` öffnen; ein `</>` Symbol erscheint in der Menüleiste.
2. Darauf klicken → **Einstellungen** → KI-Anbieter wählen und API-Key eingeben.
3. Die App einmal neu starten (Beenden → erneut öffnen), damit die Services-Einträge aktiv werden.
4. In Xcode (oder einem anderen Editor): Code markieren → Rechtsklick → **Services** → **CodeWhisper: Explain**.

> **Zurückpaste** erfordert *Bedienungshilfen*-Berechtigung:  
> Systemeinstellungen → Datenschutz & Sicherheit → Bedienungshilfen → CodeWhisper aktivieren.

---

## Architektur

```
Sources/CodeWhisper/
├── LLM/               — Provider-Protokoll + Claude / OpenAI-compat / Ollama / llama.cpp
├── PromptEngine/      — Presets und Prompt-Builder
├── ResponseFormatter/ — Markdown-Trim, Code-Block-Extraktion
├── OutputEngine/      — Popup, Zwischenablage, Benachrichtigung, Zurückpaste
├── Settings/          — Keychain, Modell, UserDefaults-Persistenz
├── UI/                — NSPanel-Popup, Statusleisten-Menü
├── AppDelegate.swift  — 7 NSServices-Selektoren → gemeinsame Pipeline
└── main.swift         — .accessory Aktivierungsrichtlinie
```

---

**Autor:** [Rafael Yilmaz](https://github.com/9t29zhmwdh-coder) · **Status:** Active · v0.1.0 · **Lizenz:** MIT
