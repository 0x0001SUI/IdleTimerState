# IdleTimerState

Control the idle timer for the SwiftUI app.

```swift
import SwiftUI
import IdleTimerState

struct ContentView: View {
    @IdleTimerState private var isAwake: Bool
    
    var body: some View {
        Form {
            Toggle("Idle Timer is Disabled", isOn: $isAwake)
            
            if isAwake {
                Text("The iPhone is always awake. It can't go into sleep mode.")
            }
        }
    }
}
```
