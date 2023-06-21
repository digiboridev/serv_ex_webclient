import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart';

abstract class SSEConnection {
  static Stream<Map<String, dynamic>> connect({required url, Map<String, String>? headers}) {
    if (kIsWeb) {
      return sseWeb(url: url, headers: headers);
    } else {
      return sseNormalPlatform(url: url, headers: headers);
    }
  }
}

/// JavaScript EventSource is not working with custom headers, as well as excception codes and multiple connections
/// Because js developers hadnt extra time to implement extra headers for new protocols like sse or ws
/// While oauth2 rfc have released 20 years ago....
/// They have time only for digidon they digidons
Stream<Map<String, dynamic>> sseWeb({required url, Map<String, String>? headers}) {
  StreamController<Map<String, dynamic>> controller = StreamController<Map<String, dynamic>>();

  final httpRequest = HttpRequest();
  httpRequest.open('GET', url);
  httpRequest.setRequestHeader('Accept', 'text/event-stream');
  headers?.forEach((key, value) {
    if (key.toLowerCase() == 'accept') throw Exception('Accept header is not allowed');
    httpRequest.setRequestHeader(key, value);
  });

  int chunkCursor = 0;
  httpRequest.addEventListener('progress', (event) {
    // Extract new data chunk from responseText
    // Because responseText is string that contains full history of data
    final dataChunk = httpRequest.responseText!.substring(chunkCursor);
    chunkCursor += dataChunk.length;

    Map<String, dynamic>? jsonResponce;
    // Try parse json from data chunk
    try {
      String json = dataChunk.substring(dataChunk.indexOf('{'), dataChunk.lastIndexOf('}') + 1);
      jsonResponce = jsonDecode(json);
    } catch (_) {}

    // If connected and data parsed - add data to stream
    // If not - close stream with error
    if (httpRequest.status == 200) {
      if (jsonResponce != null) controller.add(jsonResponce);
    } else {
      controller.addError(Exception(jsonResponce ?? httpRequest.responseText ?? 'Response error'));
      controller.close();
    }
  });

  httpRequest.addEventListener('error', (error) async {
    if (error is ErrorEvent) {
      controller.addError(Exception(error.message));
    } else {
      controller.addError(Exception(error.toString()));
    }
    await controller.close();
  });

  // Close connection once stream is cancelled by listener
  controller.onCancel = () {
    try {
      httpRequest.abort();
    } catch (_) {}
  };

  // Okk, lets go
  httpRequest.send();
  return controller.stream;
}

Stream<Map<String, dynamic>> sseNormalPlatform({required url, Map<String, String>? headers}) {
  StreamController<Map<String, dynamic>> controller = StreamController<Map<String, dynamic>>();
  final eventSource = EventSource(url);

  if (eventSource is EventSourceOutsideBrowser) {
    eventSource.onHttpClientRequest = (eventSource, request) {
      headers?.forEach((key, value) {
        request.headers.set(key, value);
      });
    };
  }

  eventSource.onMessage.listen((event) {
    controller.add(jsonDecode(event.data));
  });

  eventSource.onError.listen((error) {
    if (error is ErrorEvent) {
      controller.addError(Exception(error.message));
    } else {
      controller.addError(Exception(error.toString()));
    }
    controller.close();
    eventSource.close();
  });

  controller.onCancel = () {
    eventSource.close();
  };

  return controller.stream;
}
