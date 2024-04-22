import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/io.dart';

class WebSocketManager {
  final String webSocketUrl;
  final String myRestaurant;
  final String url;

  WebSocketManager(this.myRestaurant, this.url)
      : webSocketUrl = "wss://broadcast.sunrise-resorts.com:3000/";
  // "https://broadcast.sunrise-resorts.com:3000";

  void webSocketFireProducts() {
    // final channel = WebSocketChannel.connect(Uri.parse(webSocketUrl));

    var channel = IOWebSocketChannel.connect(webSocketUrl);

    channel.sink.add([
      'events',
      {
        "msg": {
          "to": "kitchen",
          "fire": 1,
          "message": "please handle new fired items",
          "restaurantId": myRestaurant,
          "domain": url,
          "type": "broadcast"
        }
      }
    ]);
  }

  void webSocketDeliveredProducts() {
    final channel = IOWebSocketChannel.connect(webSocketUrl);
    channel.sink.add({
      "to": "kitchen",
      "fire": 1,
      "message": "items have been delivered successfully",
      "restaurantId": myRestaurant,
      "domain": url,
      "type": "broadcast"
    });
  }

  void webSocketPickUpProducts() {
    final channel = IOWebSocketChannel.connect(webSocketUrl);
    channel.sink.add({
      "to": "waiter",
      "pickup": 1,
      "message": "please pickup items",
      "restaurantId": myRestaurant,
      "domain": url,
      "type": "broadcast"
    });
  }

  void printFiredFromWebsocket(int orderId, List<int> productsIds) {
    final channel = IOWebSocketChannel.connect(webSocketUrl);
    channel.sink.add({
      "order_id": orderId,
      "restaurantId": myRestaurant,
      "uri":
          "$url/clients/api/websocketPrintFiredProducts/$myRestaurant/$orderId",
      "productsIds": productsIds.join(','),
      "username": "",
      "type": "printing"
    });
  }
}

void main() {
  final webSocketManager =
      WebSocketManager("YOUR_RESTAURANT_ID", "YOUR_BASE_URL");

  // Example usage
  webSocketManager.webSocketFireProducts();
}
