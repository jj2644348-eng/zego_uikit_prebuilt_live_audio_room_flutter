import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

void main() {
  runApp(const OfficialTechApp());
}

class OfficialTechApp extends StatelessWidget {
  const OfficialTechApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Official Tech Love PB - Voice Room',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const RoomSetupPage(),
    );
  }
}

class RoomSetupPage extends StatefulWidget {
  const RoomSetupPage({Key? key}) : super(key: key);

  @override
  State<RoomSetupPage> createState() => _RoomSetupPageState();
}

class _RoomSetupPageState extends State<RoomSetupPage> {
  final TextEditingController _roomIdController = TextEditingController(text: "pb_room_101");
  final TextEditingController _userIdController = TextEditingController(text: "user_${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}");
  final TextEditingController _userNameController = TextEditingController(text: "Lovepreet Singh");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Official Tech Love PB - Live Audio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Voice Chat Room Setup',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _roomIdController,
              decoration: const InputDecoration(
                labelText: 'Room ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(
                labelText: 'User ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(
                labelText: 'User Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LiveAudioRoomPage(
                      roomId: _roomIdController.text,
                      userId: _userIdController.text,
                      userName: _userNameController.text,
                      isHost: true,
                    ),
                  ),
                );
              },
              child: const Text('Start Voice Room as Host', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class LiveAudioRoomPage extends StatelessWidget {
  final String roomId;
  final String userId;
  final String userName;
  final bool isHost;

  const LiveAudioRoomPage({
    Key? key,
    required this.roomId,
    required this.userId,
    required this.userName,
    required this.isHost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveAudioRoom(
        appID: 123456789, // TODO: ZegoCloud कंसोल से अपनी असली AppID यहाँ नंबर में डालें
        appSign: "YOUR_ZEGO_APP_SIGN_HERE", // TODO: ZegoCloud से मिला AppSign यहाँ डालें
        userID: userId,
        userName: userName,
        roomID: roomId,
        config: isHost
            ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
            : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience(),
      ),
    );
  }
}

