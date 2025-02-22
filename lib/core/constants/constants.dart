import 'package:manisa_case/domain/entities/message.dart';

final Map<int, List<Message>> fakeMessages = {
  1: [
    Message(id: 1, chatId: 1, senderId: "1", text: "Hey, what's up?", timestamp: DateTime.now().subtract(const Duration(minutes: 5)), isMine: false),
    Message(id: 2, chatId: 1, senderId: "me", text: "All good, how about you?", timestamp: DateTime.now().subtract(const Duration(minutes: 4)), isMine: true),
    Message(id: 3, chatId: 1, senderId: "1", text: "Just chilling!", timestamp: DateTime.now().subtract(const Duration(minutes: 2)), isMine: false),
  ],
  2: [
    Message(id: 4, chatId: 2, senderId: "2", text: "Hello!", timestamp: DateTime.now().subtract(const Duration(minutes: 10)), isMine: false),
    Message(id: 5, chatId: 2, senderId: "me", text: "Hey, how’s your day?", timestamp: DateTime.now().subtract(const Duration(minutes: 9)), isMine: true),
    Message(id: 6, chatId: 2, senderId: "2", text: "Pretty good, thanks for asking!", timestamp: DateTime.now().subtract(const Duration(minutes: 7)), isMine: false),
  ],
  3: [
    Message(id: 7, chatId: 3, senderId: "3", text: "Did you see the latest news?", timestamp: DateTime.now().subtract(const Duration(minutes: 15)), isMine: false),
    Message(id: 8, chatId: 3, senderId: "me", text: "Not yet, what's up?", timestamp: DateTime.now().subtract(const Duration(minutes: 14)), isMine: true),
    Message(id: 9, chatId: 3, senderId: "3", text: "Something really crazy happened!", timestamp: DateTime.now().subtract(const Duration(minutes: 12)), isMine: false),
    Message(id: 10, chatId: 3, senderId: "3", text: "Jake sprinted through the dense forest, his heart pounding like a war drum. The stolen artifact burned in his backpack—every shadow felt like a pursuer. Suddenly, a deafening roar echoed behind him. He turned, eyes widening as a monstrous figure emerged from the trees. It wasn’t human. The legend was real. Adrenaline surged as he leaped off a cliff, crashing into the raging river below. The creature shrieked above, but Jake was already swept away by the current. He grinned. The chase wasn’t over, but neither was he.", timestamp: DateTime.now().subtract(const Duration(minutes: 5)), isMine: false),
    Message(id: 11, chatId: 3, senderId: "3", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam quis ligula lobortis, fermentum risus vel, faucibus nunc. Praesent vel magna tincidunt, tempus ante sit amet, convallis lectus. Quisque vel ex felis. Mauris scelerisque suscipit metus vel suscipit. Praesent vestibulum convallis iaculis. Fusce velit urna, gravida dapibus felis nec, consequat ultrices urna. Nulla sed est rhoncus, vestibulum justo sit amet, tincidunt quam. Phasellus felis justo, blandit ac tristique in, consectetur ac leo. Etiam cursus tempor tempor. Quisque feugiat risus ac leo laoreet, a pretium nisl maximus.", timestamp: DateTime.now().subtract(const Duration(minutes: 4)), isMine: false),
  ],
  4: [
    Message(id: 12, chatId: 4, senderId: "4", text: "Long time no see!", timestamp: DateTime.now().subtract(const Duration(minutes: 20)), isMine: false),
    Message(id: 13, chatId: 4, senderId: "me", text: "Yeah, it's been a while!", timestamp: DateTime.now().subtract(const Duration(minutes: 19)), isMine: true),
    Message(id: 14, chatId: 4, senderId: "4", text: "We should catch up soon.", timestamp: DateTime.now().subtract(const Duration(minutes: 17)), isMine: false),
  ],
};

final String userKey = 'current_user';
