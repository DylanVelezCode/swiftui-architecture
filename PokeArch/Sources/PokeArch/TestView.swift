//
//  SwiftUIView.swift
//  
//
//  Created by Dylan Vélez on 19/07/21.
//

import SwiftUI
import Combine

protocol Store: ObservableObject {
    associatedtype State
    associatedtype Event
    associatedtype Reducer
    associatedtype Middleware
    
    var state: State { get }
    
    func dispatch(event: Event)
    
    init(initialState: State, reducer: Reducer, middlewares: [Middleware])
}

protocol ViewModel: ObservableObject {
    associatedtype ViewState
    associatedtype Event
    var state: ViewState { get }
    
    func dispatch(event: Event)
}

protocol ViewConfigurable {
    associatedtype ViewModel
    var viewModel: ViewModel { get }
}

protocol Reducer {
    associatedtype State
    associatedtype Event
    
    func reduce(state: inout State, forEvent event: Event)
}

protocol Middleware {
    associatedtype State
    associatedtype Event
    
    func intercept(state: State, forEvent event: Event) -> AnyPublisher<State, Never>
}

enum TestAction {
    case changeText
}

struct TestState {
    var count: Int = 0
}

class AnyReducer<State, Event>: Reducer {
    
    func reduce(state: inout State, forEvent event: Event) {
    }
}

class AnyMiddleware<State, Event>: Middleware {
    func intercept(state: State, forEvent event: Event) -> AnyPublisher<State, Never> {
        return Empty().eraseToAnyPublisher()
    }
}

class AppReducer: AnyReducer<TestState, TestAction> {
    override func reduce(state: inout TestState, forEvent event: TestAction) {
        switch event {
        case .changeText:
            state.count += 1
        }
    }
}

class AnyStore<State, Event>: Store {
    typealias Reducer = AnyReducer<State, Event>
    typealias Middleware = AnyMiddleware<State, Event>
    @Published private(set) var state: State
    private let reducer: Reducer
//    private let middlewares: [Middleware]
//    private var middlewareCancellables: Set<AnyCancellable> = []
    
    required init(initialState: State,
         reducer: Reducer,
         middlewares: [Middleware]) {
        self.state = initialState
        self.reducer = reducer
//        self.middlewares = middlewares
    }
    
    func dispatch(event: Event) {
        reducer.reduce(state: &state, forEvent: event)
//        for mw in middlewares {
//            mw.intercept(state: state, forEvent: event)
//                .receive(on: DispatchQueue.main)
//                .sink(receiveValue: dispatch)
//                .store(in: &middlewareCancellables)
//        }
    }
}

class TestViewModel: ViewModel {
    struct ViewState {
        var textCount: String = "Hello Test"
    }
    
    @Published var state = ViewState()
    private var store: AnyStore<TestState, TestAction>
    private var cancellables: Set<AnyCancellable> = []
    
    init(store: AnyStore<TestState, TestAction>) {
        self.store = store
        store.$state
            .sink(receiveValue: stateChanged)
            .store(in: &cancellables)
    }
    
    func dispatch(event: TestAction) {
        print("ViewModel Dispatch")
        store.dispatch(event: event)
    }
    
    private func stateChanged(newState: TestState) {
        self.state.textCount = "Count: \(newState.count)"
    }
}

struct SwiftUIView: View, ViewConfigurable {
    
    private(set) var viewModel: TestViewModel
    var body: some View {
        VStack {
            Text(viewModel.state.textCount)
            
            Button(action: {
                viewModel.dispatch(event: .changeText)
                
            }) {
                Text("Change Text")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let store = AnyStore<TestState, TestAction>(initialState: .init(count: 0),
        reducer: AppReducer(),
        middlewares: [])
        SwiftUIView(viewModel: TestViewModel(store: store))
    }
}
