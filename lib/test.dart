// import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// // Replace with your own API key
// const apiKey = "your_api_key_here";

// final chatGpt = ChatGpt(apiKey: apiKey);

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         inputDecorationTheme: InputDecorationTheme(
//           isDense: true,
//           fillColor: Colors.transparent,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.black, width: 2),
//           ),
//         ),
//       ),
//       home: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             bottom: const TabBar(
//               tabs: [
//                 Tab(icon: Text('Chat completion')),
//                 Tab(icon: Text('Completion')),
//               ],
//             ),
//           ),
//           body: const TabBarView(
//             children: [
//               ChatCompletionPage(chatGpt: chatGpt),
//               CompletionPage(chatGpt: chatGpt),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ChatCompletionPage extends StatefulWidget {
//   final ChatGpt chatGpt;

//   const ChatCompletionPage({required this.chatGpt, super.key});

//   @override
//   _ChatCompletionPageState createState() => _ChatCompletionPageState();
// }

// class _ChatCompletionPageState extends State<ChatCompletionPage> {
//   final TextEditingController _controller = TextEditingController();
//   String _response = '';

//   void _sendMessage() async {
//     final response = await widget.chatGpt.sendMessage(_controller.text);
//     setState(() {
//       _response = response;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             controller: _controller,
//             decoration: InputDecoration(
//               hintText: 'Enter your message',
//               border: OutlineInputBorder(),
//             ),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: _sendMessage,
//           child: const Text('Send'),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(_response),
//         ),
//       ],
//     );
//   }
// }

// class CompletionPage extends StatefulWidget {
//   final ChatGpt chatGpt;

//   const CompletionPage({required this.chatGpt, super.key});

//   @override
//   _CompletionPageState createState() => _CompletionPageState();
// }

// class _CompletionPageState extends State<CompletionPage> {
//   final TextEditingController _controller = TextEditingController();
//   String _response = '';

//   void _sendPrompt() async {
//     final response = await widget.chatGpt.completePrompt(_controller.text);
//     setState(() {
//       _response = response;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             controller: _controller,
//             decoration: InputDecoration(
//               hintText: 'Enter your prompt',
//               border: OutlineInputBorder(),
//             ),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: _sendPrompt,
//           child: const Text('Send'),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(_response),
//         ),
//       ],
//     );
//   }
// }
