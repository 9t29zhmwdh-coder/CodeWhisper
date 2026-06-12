# CodeWhisper

[🇩🇪 Deutsche Version](README.de.md)

**macOS AI code assistant — integrated directly into Xcode and any text editor via System Services.**

Select code, right-click → Services → CodeWhisper: Explain. That's it.

![Swift](https://img.shields.io/badge/Swift-5.9+-orange?logo=swift)
![macOS](https://img.shields.io/badge/macOS-14+-blue?logo=apple)
![License](https://img.shields.io/badge/License-MIT-green)

---

## Features

| Preset | What it does |
|---|---|
| **Explain** | Plain-English explanation of selected code |
| **Refactor** | Improves readability and best practices |
| **Optimize** | Performance-focused rewrite |
| **Add Comments** | Inserts documentation comments |
| **Find Bugs** | Analyses for bugs and edge cases |
| **Write Tests** | Generates XCTest unit tests |
| **Custom** | Your own system prompt from Settings |

### AI Providers

| Provider | Notes |
|---|---|
| Claude (Anthropic) | claude-sonnet-4-6 default |
| OpenAI | gpt-4o default |
| Mistral | mistral-large-latest default |
| Ollama | local, configurable host/port |
| llama.cpp | local, configurable host/port |

### Output Modes

- **Popup Window** — floating panel with Copy and Paste Back buttons
- **Copy to Clipboard** — silent, plus a brief notification
- **macOS Notification** — Notification Center
- **Paste Back** — replaces the selected text in the editor (requires Accessibility permission)

---

## Requirements

- macOS 14 Sonoma or later
- Xcode Command Line Tools (`xcode-select --install`)
- Swift 5.9+

---

## Build & Install

```bash
git clone https://github.com/9t29zhmwdh-coder/CodeWhisper
cd CodeWhisper
make install
```

`make install` compiles, assembles the `.app` bundle, copies it to `/Applications/`, and flushes the NSServices cache.

---

## First Launch

1. Open `/Applications/CodeWhisper.app` — a `</>` icon appears in the menu bar.
2. Click it → **Settings** → choose your provider and enter the API key.
3. Restart the menu bar app once (Quit → reopen) to activate the Services entries.
4. In Xcode (or any editor): select code → right-click → **Services** → **CodeWhisper: Explain**.

> **Paste Back** requires *Accessibility* permission:  
> System Settings → Privacy & Security → Accessibility → enable CodeWhisper.

---

## Architecture

```
Sources/CodeWhisper/
├── LLM/               — Provider protocol + Claude / OpenAI-compat / Ollama / llama.cpp
├── PromptEngine/      — Presets and prompt builder
├── ResponseFormatter/ — Markdown trim, code block extraction
├── OutputEngine/      — Popup, clipboard, notification, paste-back
├── Settings/          — Keychain, model, UserDefaults persistence
├── UI/                — NSPanel popup, status bar menu
├── AppDelegate.swift  — 7 NSServices selectors → shared pipeline
└── main.swift         — .accessory activation policy
```

---

## Project Structure

```
CodeWhisper/
├── Package.swift
├── Info.plist         — NSServices registration (7 entries), LSUIElement = true
├── Makefile           — build / bundle / install / clean
└── Sources/CodeWhisper/
```

---

**Author:** [Rafael Yilmaz](https://github.com/9t29zhmwdh-coder) · **Status:** Framework Preview · **Last Updated:** Juni 2026
