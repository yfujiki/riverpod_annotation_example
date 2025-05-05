import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
  Stream<String>? _messageStream;

  @override
  Stream<List<String>> build() {
    // Initialize an empty list
    final messages = <String>[];

    // Create a stream that accumulates messages
    _messageStream = Stream.periodic(
      const Duration(seconds: 3),
      (i) => 'Message ${i + 1}',
    ).take(5);

    return _messageStream!.map((message) {
      messages.add(message);
      return List.of(messages); // Return a new list each time
    });
  }

  void sendMessage(String message) {
    // In a real app, this would send the message to a backend
    // and the new message would come through the stream

    // Here we're just simulating the process
    // The actual implementation would depend on your backend
  }

  void clearMessages() {
    // In a real app, this might reset the stream or clear messages on backend
    // For demonstration purposes, we're not implementing the full logic
  }
}
