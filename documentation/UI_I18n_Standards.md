# Wols CA UI Internationalization (I18n) Standards

## 1. Principles of Multilingual UI
- **Zero Hardcoded Strings**: No user-facing text, button captions, dialog messages, tooltips, or window titles may be hardcoded into C++ or Python source files.
- **Dynamic Localization Dictionaries**: All strings are stored in structured external JSON dictionary files located in a dedicated `i18n/` directory.
- **Runtime Language Switching**: Changing the selected language must immediately reload the JSON mapping and refresh all active screens without requiring an application restart.

---

## 2. JSON Dictionary Format
Localization dictionary files use the standard BCP-47 language tag naming format:
* `en-US.json` (Default English base dictionary)
* `nl-NL.json` (Dutch dictionary)
* `de-DE.json` (German dictionary)

### Example JSON Schema:
```json
{
  "meta": {
    "language": "en-US",
    "version": "1.0.0"
  },
  "ui": {
    "login": {
      "title": "Wols CA Secure Access",
      "button_authenticate": "Authenticate with Windows Hello",
      "tooltip_fido2": "Touch your security key to complete login"
    },
    "status": {
      "connected": "Connected to Production Broker",
      "handshake_in_progress": "Performing Zero-Trust Verification..."
    }
  }
}
```

---

## 3. Logs and Diagnostics Separation
- **UI Strings**: Localized per user preference.
- **Diagnostic Logs, Trace Messages, Error Codes & Reports**: Strictly English only.
