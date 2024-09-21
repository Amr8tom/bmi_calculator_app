import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Import WebView package

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with a URL to load
    _controller = WebViewController()
      ..loadRequest(Uri.parse("https://sites.google.com/view/counter-app19"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Colors.black26,
      ),
      body: WebViewWidget(
        controller: _controller, // Assign the controller to WebViewWidget
      ),
    );
  }
}
