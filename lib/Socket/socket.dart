import 'dart:io';
import 'package:kawawa_motors/Shared%20Pref/sharedpref_utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void initCallingSocket() async {
  try {
    IO.Socket socket = IO.io('https://www.kawawamotorsapi.acelance.com:8020/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders' : {'Authorization' : "Bearer ${SharedPrefUtils.getToken()}"}
      // 'logLevel': IO.LogLevel.DEBUG,
    });

    socket.onConnect((_) {
      print("SOCKET CONNECTED");
      // print('get-send-chat-data');
      // socket.emit('send-chat-data', {
      //   'extraHeaders': {"Authorization": 'Bearer ${SharedPrefUtils.getToken()}',}
      // }
      // );
    });
    socket.on('get-send-chat-data', (data) {
      print("socket response");
      print(data);
    });
    socket.onDisconnect((_) => print('==!disconnect!=='));
    socket.onConnectError((data) {
      print("error001");
      print(data.toString());
    });
    socket.onerror((e) {
      print("error==");
      print(e);
    });
    socket.connect();
  } catch (e) {
    print(e);
  }
}