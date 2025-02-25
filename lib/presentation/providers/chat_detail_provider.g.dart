// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatDetailNotifierHash() =>
    r'6da9d4eef2e494ea5b29d95858dceed87bebcd2a';

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
    extends BuildlessAutoDisposeAsyncNotifier<ChatDetail> {
  late final int chatId;

  FutureOr<ChatDetail> build(
    int chatId,
  );
}

/// See also [ChatDetailNotifier].
@ProviderFor(ChatDetailNotifier)
const chatDetailNotifierProvider = ChatDetailNotifierFamily();

/// See also [ChatDetailNotifier].
class ChatDetailNotifierFamily extends Family<AsyncValue<ChatDetail>> {
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
    ChatDetailNotifier, ChatDetail> {
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
  FutureOr<ChatDetail> runNotifierBuild(
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
  AutoDisposeAsyncNotifierProviderElement<ChatDetailNotifier, ChatDetail>
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
mixin ChatDetailNotifierRef on AutoDisposeAsyncNotifierProviderRef<ChatDetail> {
  /// The parameter `chatId` of this provider.
  int get chatId;
}

class _ChatDetailNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChatDetailNotifier,
        ChatDetail> with ChatDetailNotifierRef {
  _ChatDetailNotifierProviderElement(super.provider);

  @override
  int get chatId => (origin as ChatDetailNotifierProvider).chatId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
