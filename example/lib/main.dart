import 'dart:ui';

import 'package:delivery_test/main.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Example());
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  Brightness themeModeSelected = Brightness.light;
  DeviceInfo deviceSelected = Devices.ios.iPhone13;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        color: Colors.black54,
        child: Column(
          children: [
            const SizedBox(height: 15),
            SizedBox(
              width: deviceSelected.screenSize.width,
              child: Row(
                children: [
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        return InkWell(
                          onTap: () => _onTapDevice(context),
                          child: Ink(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              deviceSelected.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: themeModeSelected._textColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 30),
                  IconButton(
                    onPressed: () => setState(() {
                      themeModeSelected = switch (themeModeSelected) {
                        Brightness.dark => Brightness.light,
                        Brightness.light => Brightness.dark,
                      };
                    }),
                    icon: Icon(
                      color: themeModeSelected._textColor,
                      switch (themeModeSelected) {
                        Brightness.dark => Icons.light_mode,
                        Brightness.light => Icons.dark_mode,
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: DeviceFrame(
                device: deviceSelected,
                screen: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    platformBrightness: themeModeSelected,
                    padding: deviceSelected.safeAreas,
                    size: deviceSelected.screenSize,
                  ),
                  child: const MainApp(),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapDevice(BuildContext context) async {
    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox) return;
    final pos = renderObject.localToGlobal(Offset.zero);
    final result = await showMenu<DeviceInfo>(
      context: context,
      position: RelativeRect.fromLTRB(
        pos.dx,
        pos.dy,
        pos.dx + renderObject.size.width,
        pos.dy + renderObject.size.height,
      ),
      initialValue: deviceSelected,
      items: [
        for (final device in _devices)
          PopupMenuItem<DeviceInfo>(
            value: device,
            child: Text(device.name),
          ),
      ],
    );
    if (result == null) return;
    setState(() => deviceSelected = result);
  }
}

extension on Brightness {
  Color get _textColor => switch (this) {
        Brightness.dark => Colors.white,
        Brightness.light => Colors.black,
      };
}

final _devices = [
  Devices.ios.iPhoneSE,
  Devices.ios.iPhone12Mini,
  Devices.ios.iPhone13,
  Devices.ios.iPhone13ProMax,
  Devices.android.smallPhone,
  Devices.android.onePlus8Pro,
  Devices.android.samsungGalaxyNote20Ultra,
];
