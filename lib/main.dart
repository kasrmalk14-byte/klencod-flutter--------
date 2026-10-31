
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const AlKaserApp());
}

const gold = Color(0xFFFFC247);
const dark = Color(0xFF090909);
const red = Color(0xFFFF4B0A);

class AlKaserApp extends StatelessWidget {
  const AlKaserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AL-KASER',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: dark,
        colorScheme: const ColorScheme.dark(
          primary: gold,
          secondary: red,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> fade;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    scale = Tween<double>(begin: 0.35, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.elasticOut),
    );

    fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );

    controller.forward();

    Timer(const Duration(seconds: 7), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF512000), dark],
            radius: 0.85,
          ),
        ),
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: fade,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: scale,
                    child: const Text(
                      '🦁',
                      style: TextStyle(fontSize: 155),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'AL-KASER',
                    style: TextStyle(
                      fontSize: 39,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                      color: gold,
                      shadows: [
                        Shadow(color: red, blurRadius: 25),
                        Shadow(color: gold, blurRadius: 15),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'الكاسر للتواصل عبر العالم',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'قوة التواصل • هيبة الأسود',
                    style: TextStyle(color: gold, fontSize: 14),
                  ),
                  const SizedBox(height: 55),
                  const CircularProgressIndicator(color: gold),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> chats = [
    {
      'name': 'أحمد',
      'message': 'السلام عليكم',
      'time': '10:30',
      'emoji': '👨',
      'unread': 2,
    },
    {
      'name': 'محمد',
      'message': 'كيف حالك؟',
      'time': '09:45',
      'emoji': '🧑',
      'unread': 1,
    },
    {
      'name': 'مجموعة الأصدقاء',
      'message': 'أهلاً بالجميع',
      'time': 'أمس',
      'emoji': '👥',
      'unread': 0,
    },
    {
      'name': 'سارة',
      'message': 'شكراً لك',
      'time': 'أمس',
      'emoji': '👩',
      'unread': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF15100A),
          title: const Text(
            'AL-KASER 🦁',
            style: TextStyle(
              color: gold,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: gold),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert, color: gold),
            ),
          ],
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: [
            chatPage(),
            simplePage(Icons.people, 'الأصدقاء'),
            simplePage(Icons.public, 'الحالات العالمية'),
            simplePage(Icons.person, 'حسابي'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: gold,
          foregroundColor: Colors.black,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('ميزة بدء محادثة جديدة')),
            );
          },
          child: const Icon(Icons.edit),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) => setState(() => selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF15100A),
          selectedItemColor: gold,
          unselectedItemColor: Colors.white54,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'الدردشات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'الأصدقاء',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: 'العالم',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'حسابي',
            ),
          ],
        ),
      ),
    );
  }

  Widget chatPage() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(17),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4B2000), Color(0xFF17100A)],
            ),
          ),
          child: const Column(
            children: [
              Text('🦁', style: TextStyle(fontSize: 48)),
              Text(
                'الكاسر للتواصل عبر العالم',
                style: TextStyle(
                  color: gold,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Text(
                'مرحباً بك في عالم الكاسر',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 27,
                  backgroundColor: const Color(0xFF38220B),
                  child: Text(
                    chat['emoji'],
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
                title: Text(
                  chat['name'],
                  style: const TextStyle(
                    color: gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  chat['message'],
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      chat['time'],
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                    if (chat['unread'] > 0)
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: red,
                        child: Text(
                          '${chat['unread']}',
                          style: const TextStyle(fontSize: 11),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(name: chat['name']),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget simplePage(IconData icon, String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: gold, size: 65),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              color: gold,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String name;

  const ChatScreen({super.key, required this.name});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final List<String> messages = [];

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add(text);
      messageController.clear();
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF17100A),
          title: Text(
            widget.name,
            style: const TextStyle(color: gold),
          ),
          actions: const [
            Icon(Icons.call, color: gold),
            SizedBox(width: 18),
            Icon(Icons.videocam, color: gold),
            SizedBox(width: 15),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: const Color(0xFF59300A),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: gold.withOpacity(0.5)),
                      ),
                      child: Text(
                        messages[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: const Color(0xFF17100A),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'اكتب رسالتك...',
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: const Color(0xFF292015),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send, color: gold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
