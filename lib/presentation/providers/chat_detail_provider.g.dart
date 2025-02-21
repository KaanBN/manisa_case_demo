// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatDetailNotifierHash() =>
    r'815e36a5d027547b31d000753680e95ced7964e0';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ChatDetailNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<Message>> {
  late final int chatId;

  FutureOr<List<Message>> build(
    int chatId,
  );
}

/// See also [ChatDetailNotifier].
@ProviderFor(ChatDetailNotifier)
const chatDetailNotifierProvider = ChatDetailNotifierFamily();

/// See also [ChatDetailNotifier].
class ChatDetailNotifierFamily extends Family<AsyncValue<List<Message>>> {
  /// See also [ChatDetailNotifier].
  const ChatDetailNotifierFamily();

  /// See also [ChatDetailNotifier].
  ChatDetailNotifierProvider call(
    int chatId,
  ) {
    return ChatDetailNotifierProvider(
      chatId,
    );
  }

  @override
  ChatDetailNotifierProvider getProviderOverride(
    covariant ChatDetailNotifierProvider provider,
  ) {
    return call(
      provider.chatId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatDetailNotifierProvider';
}

/// See also [ChatDetailNotifier].
class ChatDetailNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ChatDetailNotifier, List<Message>> {
  /// See also [ChatDetailNotifier].
  ChatDetailNotifierProvider(
    int chatId,
  ) : this._internal(
          () => ChatDetailNotifier()..chatId = chatId,
          from: chatDetailNotifierProvider,
          name: r'chatDetailNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatDetailNotifierHash,
          dependencies: ChatDetailNotifierFamily._dependencies,
          allTransitiveDependencies:
              ChatDetailNotifierFamily._allTransitiveDependencies,
          chatId: chatId,
        );

  ChatDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatId,
  }) : super.internal();

  final int chatId;

  @override
  FutureOr<List<Message>> runNotifierBuild(
    covariant ChatDetailNotifier notifier,
  ) {
    return notifier.build(
      chatId,
    );
  }

  @override
  Override overrideWith(ChatDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatDetailNotifierProvider._internal(
        () => create()..chatId = chatId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatId: chatId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ChatDetailNotifier, List<Message>>
      createElement() {
    return _ChatDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatDetailNotifierProvider && other.chatId == chatId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChatDetailNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<Message>> {
  /// The parameter `chatId` of this provider.
  int get chatId;
}

class _ChatDetailNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChatDetailNotifier,
        List<Message>> with ChatDetailNotifierRef {
  _ChatDetailNotifierProviderElement(super.provider);

  @override
  int get chatId => (origin as ChatDetailNotifierProvider).chatId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
