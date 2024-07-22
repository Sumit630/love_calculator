import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyAppState();
}

class _PrivacyPolicyAppState extends State<PrivacyPolicy> {
  late final WebViewController webViewController;
  String privacyPolicyUrl = "https://sites.google.com/view/onlytools/home";

  @override
  void initState() {
    super.initState();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
        ),
      )
      ..loadRequest(
        Uri.parse(privacyPolicyUrl),
        headers: {
          "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"
        },
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.redAccent,
        title: Text(
          "Love Calculator",
          style: GoogleFonts.rubik(
              fontSize: 24, fontWeight: FontWeight.w200, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: WebViewWidget(
              controller: webViewController,
            ),
          ),
        ],
      ),
    );
  }
}
