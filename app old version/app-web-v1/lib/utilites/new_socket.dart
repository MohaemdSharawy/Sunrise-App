import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIo {
  // final String webSocketUrl = '';
  final String url;
  final String myRestaurant;
  IO.Socket socket;

  SocketIo(this.myRestaurant, this.url)
      : socket = IO.io(
          'https://broadcast.sunrise-resorts.com:3000',
          <String, dynamic>{
            'transports': ['websocket'],
          },
        );

  void connectToSocket() {
    print('start socket Io');
    if (socket != null && socket.connected) {
      socket.disconnect();
    }
    socket.connect();

    socket.on('connect', (_) {
      print('Connected to WebSocket');
      webSocketFireProducts();
    });

    socket.on('disconnect', (_) {
      print('Disconnected from WebSocket');
    });

    // socket = IO.io(webSocketUrl, <String, dynamic>{
    //   'transports': ['websocket'],
    // });

    // socket.on('connect', (_) {
    //   print('Connected to WebSocket');
    //   webSocketFireProducts(socket);
    // });

    // socket.on('connecting', (_) {
    //   print('u YOur Connected');
    //   webSocketFireProducts(socket);
    // });

    // socket.on('reconnect', (_) {
    //   print('reconnect');
    //   webSocketFireProducts(socket);
    // });
    // socket.on('disconnect', (_) {
    //   print('Disconnected from WebSocket');
    // });
  }

  void webSocketFireProducts() {
    Map<String, dynamic> msg = {
      'to': 'kitchen',
      'fire': 1,
      'pickup': 0,
      'restaurantId': myRestaurant,
      'domain': url,
      'message': 'please handle new fired items',
      'type': 'broadcast',
    };

    socket.emit('events', {'msg': msg});
  }

  void disconnectFromSocket(socket) {
    if (socket != null && socket.connected) {
      socket.disconnect();
      print('Disconnected from WebSocket');
    }
  }
}
