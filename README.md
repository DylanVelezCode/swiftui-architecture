# What is Poke?

Poke is an app developed with the purpose of showcasing a new way of architecturing iOS applications which applies both to SwiftUI and UIKit apps, although this particular one was developed with SwiftUI.

The app is fully featured, including the use of different services, the ability to replace such services for different implementations, displaying different screens and functionality such as a pokemon list, pokemon detail and pokemon favorites

<img src="https://drive.google.com/uc?export=view&id=1P3uP8_k9QCTuG0JtZabASJXxU7QM1M_g" width="200" />
<img src="https://drive.google.com/uc?export=view&id=137XGY1Lvh_BfuqxL6q67vqizGb4xXYGt" width="200" />
<img src="https://drive.google.com/uc?export=view&id=12BRyMlAbH7uHLann3A-bSBel97XZ_Ykv" width="200" />

# Requirements

The requirements to run this app are:

- `Xcode 13` or greater
- `iOS 15` or greater

The requirements for the architecture are:

- `Xcode 11` or greater
- `iOS 13` or greater

Although this architecture can be rethought for any other environment and even other platforms like Android using jetpack compose.

# What is the ReArch?

ReArch is an architecture thought to make applications easier to develop by removing a lot of the cumbersome boilerplate introduced by other architechtures like VIPER or MVVM where you need to create lots of files just to introduce a small feature and state management is all over the place.

While coming up with this architecture, I realized it is pretty similar to the composable architecture which you can read more about here at
[point-free](https://www.pointfree.co/collections/composable-architecture/swiftui-and-state-management/ep65-swiftui-and-state-management-part-1)

# How does it work?

<img src="https://drive.google.com/uc?export=view&id=1z8Eva1Z9N0U4THtUp-yV4f7-qEE4uj05"/>

According to the above diagram, this architecture is based on the thought that a View should only depend on it's view model. From there, the view model dispatches any events that happen to the store which in turn passes the event and the store's state to a reducer which will change the state accordingly using any services, workers or other dependencies.

### Single source of truth

For any given View, Screen, Feature or even for the whole app, you should only depend on one single state. In this architecture the only entity in charge of the state is the store and the only other entity capable of changing it is the reducer, not the view model and not even the services.

### Unidirectional data flow

One of the advantages of this approach is that the state flows in a single direction towards the view which needs to display it. None of the dependencies except for the reducer can directly modify the state of the feature, the view model receives it and formats it for the view to display.

### Modularity

The architecture is designed to be flexible and modular enough so each feature and sub-feature can be designed and developed independently from each other. This means the developers can work on multiple screens at a time and even on the same screen but different components, each one with it's own state and functionality.

## Components

### The State

The State is the data the feature needs for functioning well.
The definition of state is recommended to be a data struct which contains only simple data types and if possible, as many primitive types as possible over complex types.

```Swift
struct ListState {
var list = []
var isLoading = false
}
```

### The Events

This architecture is based on events, meaning that for every time the state of the app needs to change the state you must dispatch an event. 
Events are defined by enum cases which make it a more readable codebase, new functionality is easier to implement since you must just add a new case and fill in the blanks where the enum is being used and the domain logic is only handled in the reducer. With this we can have a deterministic application.

Each event can be as obvious as events triggered by the UI like a button tap, but normally events are more complicated than that. Whenever you trigger an event, it can trigger more events which we call side effects. For example you can define two events for fetching data, one where you actually fetch the data and another one for when the data is done being fetched. 

```Swift
enum ListEvent {
case fetchData
case fetchDataCompleted(result: Result<Data, Error>)
case showDetail
}
```

### The View

A View can be any UIKit's view or SwiftUI's View. 

### The ViewModel and ViewState

The ViewModel is responsible for giving the view the state it needs via a property binding. The ViewModel dispatches events to the store and receives the new state, which it formats and adapts to forward back to the view.

```Swift
public protocol ViewModel: ObservableObject, Dispatching {
    associatedtype StoreState
    associatedtype ViewState
    associatedtype Store
    var state: ViewState { get }
    var store: Store { get set }
    
    func stateChanged(newState: StoreState)
}

extension ViewModel where Self.Store: Dispatching, Self.Store.Event == Self.Event {
    public func dispatch(event: Event) {
        store.dispatch(event: event)
    }
}
```

The ViewModel has an associated store to which forward the events. It needs to be an observable object so the view can react to the state changes.

The ViewState is an associated type which is defined by every viewModel implementation. It should be a simple data struct with as simplest types as possible.

```Swift
struct ViewState {
    var isFavorite: Bool = false
    var name: String = ""
    var url: URL? = nil
    var types: [String] = []
    var id: Int = 0
}
```

### The Store

The store is a simple class with the sole purpose of dispatching events to the reducer and forwarding the state to the view models through a property publisher.
There should be only one implementation of a store, since it is not prone to change and it shouldn't have any bussiness logic or any other logic at all than forwarding events to a reducer.

```Swift
fileprivate typealias StoreType = ObservableObject & Dispatching

/// Generic Store which dispatches events and it's current state to the reducers 
public final class Store<State, Event, Reducer: Reducing>: StoreType where Reducer.State == State, Reducer.Event == Event {
    
    private let reducer: Reducer
    private var effectsCancellable: AnyCancellable?
    
    @Published private(set) public var state: State
    
    required public init(initialState: State,
         reducer: Reducer) {
        self.state = initialState
        self.reducer = reducer
    }
    
    public func dispatch(event: Event) {
        guard let publisher = reducer.reduce(state: &state, forEvent: event) else {
            return
        }
        
        effectsCancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: dispatch)
    }
}
```

### The Reducer
```Swift
public typealias Effect<Event> = AnyPublisher<Event, Never>?

/// Defines a type which changes a given state for a specific event and returns a new side effect
public protocol Reducing {
    associatedtype State
    associatedtype Event
    func reduce(state: inout State, forEvent event: Event) -> Effect<Event>
}
```

A Reducer is a type who processes events passed to it and modifies a given state which it receives by reference as an inout parameter. 
If the change required needs to happen asynchronously like when calling a service or a background worker, the reducer can return a publisher with a new event which the store will dispatch again to the reducer and it will then process the according state

```Swift
public struct Reducer: Reducing, Depending {
    public typealias State = ListState
    public typealias Event = ListEvent
    public typealias Dependencies = ListDependencies
    
    var dependencies: Dependencies
    
    public func reduce(state: inout State, forEvent event: Event) -> Effect<Event> {
        switch event {
        case .fetchData:
            state.list = []
            state.isLoading = true
        case .fetchDataCompleted(let newData):
            state.list = newData
            state.isLoading = false
        }
        
        return sideEffect(event: event)
    }
    
    private func sideEffect(event: PokeListEvent) -> Effect<PokeListEvent> {
        switch event {
        case .fetchPokemon:
            return dependencies.listService.getList()
                .map(ListEvent.fetchDataCompleted)
                .replaceError(with: .fetchDataCompleted(data: []))
                .merge(with: logger)
                .eraseToAnyPublisher()
        case .fetchPokemonCompleted:
            return nil
        }
    }
}
```

What the reducer does is intercept the fetchData event and then call the dependencies to get new data, which returns a publisher to eventually publish a new event with the data received from the services. The reducer will again intercept this event and set the state accordingly.

# Packages and Modularity

The approach to dependency injection and architecture allows for development to be moduralized by having certain components be isolated with packages and frameworks.

The architecture definitions are themselves stored in the `PokeArch` package.
The Injection logic is stored in the `PokeInjection` package.
The Domain logic which includes the possible states and events beside the reducers for each functionality, are stored in the `PokeDomain`. Each Feature could also be stored in a different package since they don't depend on each other.
The Models are stored in the `PokeModels` package.
The services are stored in the `PokeServices` package.

The app's views and their respective view models are defined inside the application target. This way, different teams can work on different packages.

