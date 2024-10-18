import 'package:flutter/material.dart';
import 'mqtt_service.dart'; // Mengimpor layanan MQTT

class HomeControl extends StatefulWidget {
  const HomeControl({super.key});

  @override
  State<HomeControl> createState() => _HomeControlState();
}

class _HomeControlState extends State<HomeControl> {
  final MqttService mqttService = MqttService();

  // Variabel untuk status switch setiap LED
  bool isLed0On = false;
  bool isLed1On = false;
  bool isLed2On = false;
  bool isLed3On = false;

  @override
  void initState() {
    super.initState();
    mqttService.connect(); // Menghubungkan ke MQTT saat inisialisasi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Auto Lamp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Switch untuk LED 0
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('LED 0'),
                Switch(
                  value: isLed0On,
                  onChanged: (value) {
                    setState(() {
                      isLed0On = value;
                      mqttService.publishMessage(
                          'ledControl/LED0', isLed0On ? 'on' : 'off');
                    });
                  },
                ),
              ],
            ),
            // Switch untuk LED 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('LED 1'),
                Switch(
                  value: isLed1On,
                  onChanged: (value) {
                    setState(() {
                      isLed1On = value;
                      mqttService.publishMessage(
                          'ledControl/LED1', isLed1On ? 'on' : 'off');
                    });
                  },
                ),
              ],
            ),
            // Switch untuk LED 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('LED 2'),
                Switch(
                  value: isLed2On,
                  onChanged: (value) {
                    setState(() {
                      isLed2On = value;
                      mqttService.publishMessage(
                          'ledControl/LED2', isLed2On ? 'on' : 'off');
                    });
                  },
                ),
              ],
            ),
            // Switch untuk LED 3
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('LED 3'),
                Switch(
                  value: isLed3On,
                  onChanged: (value) {
                    setState(() {
                      isLed3On = value;
                      mqttService.publishMessage(
                          'ledControl/LED3', isLed3On ? 'on' : 'off');
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
