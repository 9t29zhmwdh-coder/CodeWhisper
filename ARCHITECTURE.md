# Architecture

## Overview

CodeWhisper is a macOS AI code assistant that hooks into the system via NSServices,
allowing any text selection to be processed by an AI model via the right-click menu.

```
CodeWhisper/
├── CodeWhisperApp.swift      # App entry, NSServices registration
├── Services/
│   ├── NSServicesHandler.swift  # NSServices callbacks
│   └── AIService.swift          # AI backend abstraction
├── Backends/
│   ├── OllamaBackend.swift
│   ├── LlamaCppBackend.swift
│   └── CloudBackend.swift
├── Actions/
│   ├── ExplainAction.swift
│   ├── RefactorAction.swift
│   ├── OptimizeAction.swift
│   ├── AddCommentsAction.swift
│   ├── FindBugsAction.swift
│   └── WriteTestsAction.swift
└── UI/
    └── ResultPanel.swift
```

## Design Decisions

- **NSServices:** Native macOS integration — no accessibility permissions needed.
- **Backend abstraction:** Swap local/cloud AI without changing action code.
- **Pure Foundation:** No third-party dependencies for core logic.

## CI

```yaml
name: CI
on: [push, pull_request]
jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      - run: swift build
      - run: swift test
```
