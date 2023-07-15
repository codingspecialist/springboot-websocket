import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/hello_stream_provider.dart';

void main() {
  stompClient.activate();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helloData = ref.watch(helloStreamProvider);
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: helloData.when(
            data: (data) {
              String content = jsonDecode(data)["content"];
              return buildText(content);
            },
            error: (error, stackTrace) => buildText("Error"),
            loading: () => buildText("No Data"),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            int randomNumber = math.Random().nextInt(100);
            stompClient.send(
              destination: '/app/hello',
              body: json.encode({"content": "$randomNumber"}),
              headers: {},
            );
          },
          child: const Icon(Icons.send),
        ),
      ),
    );
  }

  Text buildText(String content) {
    return Text(
      content,
      style: const TextStyle(
        fontSize: 100,
      ),
    );
  }
}
