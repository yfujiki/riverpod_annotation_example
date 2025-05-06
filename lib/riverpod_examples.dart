import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

// This creates a file called 'riverpod_examples.g.dart'
part 'riverpod_examples.g.dart';

// ----------------------
// 1. Provider Example
// ----------------------
@riverpod
String helloWorld(Ref ref) {
  return 'Hello world';
}

// Usage example:
// final greeting = ref.watch(helloWorldProvider);

// ----------------------
// 2. FutureProvider Example
// ----------------------
@riverpod
Future<List<String>> fetchUserNames(Ref ref) async {
  // Simulate API call with a delay
  await Future.delayed(const Duration(seconds: 2));
  return ['Alice', 'Bob', 'Charlie', 'David'];
}

// Usage example:
// final usersAsyncValue = ref.watch(fetchUserNamesProvider);
// usersAsyncValue.when(
//   data: (users) => ListView.builder(...),
//   loading: () => CircularProgressIndicator(),
//   error: (err, stack) => Text('Error: $err'),
// );

// ----------------------
// 3. StreamProvider Example
// ----------------------
@riverpod
Stream<int> counter(Ref ref) {
  return Stream.periodic(
    const Duration(seconds: 1),
    (count) => count,
  ).take(10); // Will emit 0 to 9
}

// Usage example:
// final counterStream = ref.watch(counterProvider);
// counterStream.when(
//   data: (count) => Text('$count'),
//   loading: () => CircularProgressIndicator(),
//   error: (err, stack) => Text('Error: $err'),
// );

// ----------------------
// 4. NotifierProvider Example
// ----------------------
@riverpod
class CounterNotifier extends _$CounterNotifier {
  @override
  int build() {
    return 0; // Initial state
  }

  void increment() {
    state++;
  }

  void decrement() {
    if (state > 0) {
      state--;
    }
  }

  void reset() {
    state = 0;
  }
}

// Usage example:
// final count = ref.watch(counterNotifierProvider);
// ref.read(counterNotifierProvider.notifier).increment();

// ----------------------
// 5. AsyncNotifierProvider Example
// ----------------------
@riverpod
class TodosNotifier extends _$TodosNotifier {
  @override
  Future<List<String>> build() async {
    // Simulate API fetch
    await Future.delayed(const Duration(seconds: 1));
    return ['Buy milk', 'Walk the dog', 'Study Riverpod'];
  }

  Future<void> addTodo(String task) async {
    // Optimistic update
    state = AsyncData([...state.value ?? [], task]);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // In a real app, you would handle errors here
  }

  Future<void> removeTodo(String task) async {
    if (state.value == null) return;

    // Optimistic update
    state = AsyncData(state.value!.where((t) => t != task).toList());

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // In a real app, you would handle errors here
  }
}

// Usage example:
// final todosAsync = ref.watch(todosNotifierProvider);
// final todosNotifier = ref.watch(todosNotifierProvider.notifier);
// todosNotifier.addTodo('Learn Flutter');

// ----------------------
// 6. StreamNotifierProvider Example
// ----------------------
@riverpod
class MessageStreamNotifier extends _$MessageStreamNotifier {
  // Add this to your dependencies in pubspec.yaml:
  // rxdart: ^0.27.7

  late final BehaviorSubject<List<String>> _messagesSubject;

  @override
  Stream<List<String>> build() {
    // Initialize the BehaviorSubject with an empty list
    _messagesSubject = BehaviorSubject<List<String>>.seeded([]);

    // Periodically add demo messages
    final periodicMessagesSubscription = Stream.periodic(
      const Duration(seconds: 3),
      (i) => 'System message ${i + 1}',
    ).take(5).listen((message) {
      final currentMessages = _messagesSubject.value;
      currentMessages.add(message);
      _messagesSubject.add(
        List.of(currentMessages),
      ); // Add a new list to trigger updates
    });

    // Make sure to cancel the subscription when the provider is disposed
    ref.onDispose(() {
      periodicMessagesSubscription.cancel();
      _messagesSubject.close();
    });

    // Return the subject as a stream
    return _messagesSubject.stream;
  }

  void sendMessage(String message) {
    // Get the current messages
    final currentMessages = _messagesSubject.value;

    // Add the new message
    currentMessages.add('User: $message');

    // Emit a new list (important for reactivity)
    _messagesSubject.add(List.of(currentMessages));

    // In a real app with a backend, you might do something like:
    // 1. Send the message to your backend API
    // 2. The backend would then broadcast the message to all clients
    // 3. Your app would receive the message via a WebSocket or similar
    // 4. That would update the BehaviorSubject
  }

  void clearMessages() {
    // Reset to an empty list
    _messagesSubject.add([]);

    // In a real app, you might also want to:
    // 1. Send a request to your backend to clear chat history
    // 2. Handle any success/failure responses
    // 3. Update the UI accordingly
  }
}
