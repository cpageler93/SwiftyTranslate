# SwiftyTranslate

Swift Implementation for Google Translate

```swift
import SwiftyTranslate

SwiftyTranslate.translate(text: "Hello World", from: "en", to: "de") { result in
    switch result {
    case .success(let translation):
        print("Translated: \(translation.translated)")
    case .failure(let error):
        print("Error: \(error)")
    }
}
```