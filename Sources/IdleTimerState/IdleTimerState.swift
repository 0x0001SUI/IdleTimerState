#if os(iOS)
import SwiftUI
import Combine


/// A property wrapper type that controls whether the idle timer is disabled for the app.
@available(iOS 14, *)
@propertyWrapper
public struct IdleTimerState: DynamicProperty {
    @StateObject private var model = Model()

    public init() {}
    
    public var wrappedValue: Bool {
        get {
            model.isAwake
        }
        nonmutating set {
            model.isAwake = newValue
        }
    }
    
    public var projectedValue: Binding<Bool> {
        Binding {
            model.isAwake
        } set: {
            model.isAwake = $0
        }
    }
}


// MARK: - Model

private extension IdleTimerState {
    private class Model: ObservableObject {
        @Published var isAwake: Bool
            
        init() {
            self.isAwake = app.isIdleTimerDisabled
            
            self.app
                .publisher(for: \.isIdleTimerDisabled)
                .filter { self.isAwake != $0 }
                .assign(to: \.isAwake, on: self)
                .store(in: &self.cancellable)
            
            self.$isAwake
                .filter { self.app.isIdleTimerDisabled != $0 }
                .assign(to: \.isIdleTimerDisabled, on: self.app)
                .store(in: &self.cancellable)
            
        }
        
        private let app: UIApplication = .shared
        private var cancellable = Set<AnyCancellable>()
    }
}
#endif
