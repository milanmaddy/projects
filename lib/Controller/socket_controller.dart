import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../Shared Pref/sharedpref_utils.dart';

class SocketController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initSocket();
    print('LISTENER ACTIVATED');
  }

  IO.Socket? socket;

  initSocket() {
    socket = IO.io(
        'https://www.kawawamotorsapi.acelance.com:8020/', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
      'extraHeaders' : {'Authorization' : "Bearer ${SharedPrefUtils.getToken()}"}
    });
    socket!.onConnect((_) {
      print("SOCKET CONNECTED");
      // print('get-send-chat-data');
      // socket.emit('send-chat-data', {
      //   'extraHeaders': {"Authorization": 'Bearer ${SharedPrefUtils.getToken()}',}
      // }
      // );
    });
    socket!.on('get-send-chat-data', (data) {
      print("socket response");
      print(data);
    });
    socket!.onDisconnect((_) => print('==!disconnect!=='));
    socket!.onConnectError((data) {
      print("error001");
      print(data.toString());
    });
    socket!.onerror((e) {
      print("error==");
      print(e);
    });
    socket!.connect();
  }

  socketEmit(String inboxID, Object conversion) {
    var socketEmit = {
      'conversion': conversion,
      "inboxId": inboxID
    };
    socket!.emit("send-chat-data", socketEmit);
    print('EMITTED');
  }

  socketListener(){
    socket!.on('get-send-chat-data', (data){
      // data.emit
      print('HERE IS LISTENER DATA');
      print(data);
    });
  }

}