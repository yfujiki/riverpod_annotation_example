// Usage example:
// final messagesStream = ref.watch(messageStreamNotifierProvider);
// final messageNotifier = ref.watch(messageStreamNotifierProvider.notifier);
// messageNotifier.sendMessage('Hello!');

// ----------------------
// Complete Usage Example in a Widget
// ----------------------
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'riverpod_examples.dart';

class RiverpodExampleWidget extends ConsumerWidget {
  const RiverpodExampleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Using Provider
    final greeting = ref.watch(helloWorldProvider);

    // Using NotifierProvider
    final count = ref.watch(counterNotifierProvider);

    // Using FutureProvider
    final usersAsync = ref.watch(fetchUserNamesProvider);

    // Using StreamProvider
    final counterValue = ref.watch(counterProvider);

    // Using AsyncNotifierProvider
    final todosAsync = ref.watch(todosNotifierProvider);

    // Using StreamNotifierProvider
    final messagesAsync = ref.watch(messageStreamNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Riverpod Examples')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Provider example
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Provider Example',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(greeting),
                ],
              ),
            ),
          ),

          // NotifierProvider example
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NotifierProvider Example',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Count: $count'),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed:
                            () =>
                                ref
                                    .read(counterNotifierProvider.notifier)
                                    .increment(),
                        child: Text('Increment'),
                      ),
                      ElevatedButton(
                        onPressed:
                            () =>
                                ref
                                    .read(counterNotifierProvider.notifier)
                                    .decrement(),
                        child: Text('Decrement'),
                      ),
                      ElevatedButton(
                        onPressed:
                            () =>
                                ref
                                    .read(counterNotifierProvider.notifier)
                                    .reset(),
                        child: Text('Reset'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // FutureProvider example
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FutureProvider Example',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  usersAsync.when(
                    data:
                        (users) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Users:'),
                            ...users.map(
                              (user) => Padding(
                                padding: EdgeInsets.only(left: 16, top: 4),
                                child: Text('• $user'),
                              ),
                            ),
                          ],
                        ),
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Text('Error: $err'),
                  ),
                ],
              ),
            ),
          ),

          // StreamProvider example
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'StreamProvider Example',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  counterValue.when(
                    data: (count) => Text('Stream count: $count'),
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Text('Error: $err'),
                  ),
                ],
              ),
            ),
          ),

          // AsyncNotifierProvider example
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AsyncNotifierProvider Example',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  todosAsync.when(
                    data:
                        (todos) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Todos:'),
                            ...todos.map(
                              (todo) => Padding(
                                padding: EdgeInsets.only(left: 16, top: 4),
                                child: Row(
                                  children: [
                                    Text('• $todo'),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed:
                                          () => ref
                                              .read(
                                                todosNotifierProvider.notifier,
                                              )
                                              .removeTodo(todo),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed:
                                  () => ref
                                      .read(todosNotifierProvider.notifier)
                                      .addTodo(
                                        'New task ${DateTime.now().second}',
                                      ),
                              child: Text('Add Todo'),
                            ),
                          ],
                        ),
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Text('Error: $err'),
                  ),
                ],
              ),
            ),
          ),

          // StreamNotifierProvider example
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'StreamNotifierProvider Example',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  messagesAsync.when(
                    data:
                        (messages) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Messages:'),
                            if (messages.isEmpty)
                              Padding(
                                padding: EdgeInsets.only(left: 16, top: 4),
                                child: Text('No messages yet'),
                              )
                            else
                              ...messages.map(
                                (message) => Padding(
                                  padding: EdgeInsets.only(left: 16, top: 4),
                                  child: Text('• $message'),
                                ),
                              ),
                          ],
                        ),
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Text('Error: $err'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Main app
class RiverpodDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Riverpod Examples',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: RiverpodExampleWidget(),
      ),
    );
  }
}

void main() {
  runApp(RiverpodDemo());
}
