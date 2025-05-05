// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'riverpod_examples.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$helloWorldHash() => r'8bbe6cff2b7b1f4e1f7be3d1820da793259f7bfc';

/// See also [helloWorld].
@ProviderFor(helloWorld)
final helloWorldProvider = AutoDisposeProvider<String>.internal(
  helloWorld,
  name: r'helloWorldProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$helloWorldHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HelloWorldRef = AutoDisposeProviderRef<String>;
String _$fetchUserNamesHash() => r'a856cf603b030a37fcccc5be55994ebba14a27a6';

/// See also [fetchUserNames].
@ProviderFor(fetchUserNames)
final fetchUserNamesProvider = AutoDisposeFutureProvider<List<String>>.internal(
  fetchUserNames,
  name: r'fetchUserNamesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$fetchUserNamesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchUserNamesRef = AutoDisposeFutureProviderRef<List<String>>;
String _$counterHash() => r'3b99b8d62b470d2a80f0547c12897609560578a4';

/// See also [counter].
@ProviderFor(counter)
final counterProvider = AutoDisposeStreamProvider<int>.internal(
  counter,
  name: r'counterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$counterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CounterRef = AutoDisposeStreamProviderRef<int>;
String _$counterNotifierHash() => r'4feee6e574c7eb45ea91ab79372bdc325443002c';

/// See also [CounterNotifier].
@ProviderFor(CounterNotifier)
final counterNotifierProvider =
    AutoDisposeNotifierProvider<CounterNotifier, int>.internal(
      CounterNotifier.new,
      name: r'counterNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$counterNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CounterNotifier = AutoDisposeNotifier<int>;
String _$todosNotifierHash() => r'59f3d0112f94a1cd636e0584f8268be0fea9aae5';

/// See also [TodosNotifier].
@ProviderFor(TodosNotifier)
final todosNotifierProvider =
    AutoDisposeAsyncNotifierProvider<TodosNotifier, List<String>>.internal(
      TodosNotifier.new,
      name: r'todosNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$todosNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TodosNotifier = AutoDisposeAsyncNotifier<List<String>>;
String _$messageStreamNotifierHash() =>
    r'f364ea4fe5dd4ab9c11c0ddd3d4df0f9f5ba9100';

/// See also [MessageStreamNotifier].
@ProviderFor(MessageStreamNotifier)
final messageStreamNotifierProvider = AutoDisposeStreamNotifierProvider<
  MessageStreamNotifier,
  List<String>
>.internal(
  MessageStreamNotifier.new,
  name: r'messageStreamNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$messageStreamNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MessageStreamNotifier = AutoDisposeStreamNotifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
