import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_telekom/constants/colors.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../constants/styles.dart';
import '../../elements/screen_templates.dart';

enum Networks {
  private,
  business,
  businessVPN,
}

/// QR code for connecting to WiFi has to have this format:
/// "WIFI:T:WPA;S:<SSID>;P:<PASSWORD>;;"
///
/// See also:https://feeding.cloud.geek.nz/posts/encoding-wifi-access-point-passwords-qr-code/

class QRCodeGenerator extends StatefulWidget {
  final String ssid;
  final String password;
  final String ssid2;
  final String password2;

  const QRCodeGenerator(
      {Key? key,
      this.ssid = "remoto-business-wifi",
      this.password = "ABCDEFG12345",
      this.ssid2 = "remoto-private-wifi",
      this.password2 = "12345"})
      : super(key: key);

  @override
  State<QRCodeGenerator> createState() =>
      _QRCodeGeneratorState(ssid, password, ssid2, password2);
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  final String ssid;
  final String password;
  final String ssid2;
  final String password2;
  Networks _selectedNetwork = Networks.private;

  _QRCodeGeneratorState(this.ssid, this.password, this.ssid2, this.password2);

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
        child: Center(
          child: Column(children: [
            const H1("Separate business from your private life.",
                color: Colors.white),
            const SizedBox(height: 0),
            const Infobox(
                "Your business devices run in a separate home network that is not affected by security issues of your home devices. When devices compete for bandwidth, your business network always gets priority."),
            const SizedBox(height: 20),
            const T1("Choose network:"),
            CupertinoSlidingSegmentedControl<Networks>(
                onValueChanged: (Networks? value) {
                  if (value != null) {
                    setState(() {
                      _selectedNetwork = value;
                    });
                  }
                },
                groupValue: _selectedNetwork,
                children: <Networks, Widget>{
                  Networks.private: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Text(
                      'Private',
                      style: TextStyle(color: CupertinoColors.black),
                    ),
                  ),
                  Networks.business: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Business',
                            style: TextStyle(color: CupertinoColors.black),
                          ),
                          Icon(
                            Icons.shield_outlined,
                            size: 18,
                            color: MyColors.lightBlue,
                          )
                        ]),
                  ),
                  Networks.businessVPN: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Pro VPN',
                            style: TextStyle(color: CupertinoColors.black),
                          ),
                          Icon(
                            Icons.shield,
                            size: 18,
                            color: MyColors.lightBlue,
                          )
                        ]),
                  ),
                }),
            const SizedBox(height: 20),
            PrettyQr(
              //image: AssetImage('images/twitter.png'),
              size: 200,
              data: _selectedNetwork == Networks.business
                  ? "WIFI:T:WPA;S:${ssid};P:${password};;"
                  : "WIFI:T:WPA;S:${ssid2};P:${password2};;",
              errorCorrectLevel: QrErrorCorrectLevel.M,
              roundEdges: true,
            ),
          ]),
        ),
      ),
    );
  }
}
