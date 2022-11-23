//
//  ViewController.swift
//  WebViewJSLiveDemo
//
//  Created by chantil on 2022/11/21.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    let htmlTitleLabel = UILabel().updateText("HTML").autolayout()
    let jsTitleLabel = UILabel().updateText("JavaScript").autolayout()
    let webViewTitleLabel = UILabel().updateText("WebView").autolayout()
    let consoleTitleLabel = UILabel().updateText("Console: webView.evaluateJavaScript()").autolayout()

    let htmlTextView = UITextView().autolayout().autoCorrection(.no).autoCapitalization(.none)
    let jsTextView = UITextView().autolayout().autoCorrection(.no).autoCapitalization(.none)
    let webView = WKWebView().autolayout()
    let consoleTextView = UITextView().autolayout().autoCorrection(.no).autoCapitalization(.none).editable(false)

    var html: String {
        htmlTextView.text ?? ""
    }
    var javascript: String {
        jsTextView.text ?? ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        htmlTextView.text = """
        <h1 style="color:#ff0000">hello</h1>
        <br>
        <img src="https://picsum.photos/id/2/400/400">
        """
        htmlTextView.delegate = self

        jsTextView.text = """
        document.getElementsByTagName('h1')[0].innerHTML = 'Hello, world!';
        document.documentElement.outerHTML.trim();
        """
        jsTextView.delegate = self

        webView.navigationDelegate = self
        webView.loadHTMLString(html, baseURL: nil)
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground

        view.addSubview(htmlTitleLabel)
        view.addSubview(jsTitleLabel)
        view.addSubview(webViewTitleLabel)
        view.addSubview(consoleTitleLabel)
        view.addSubview(htmlTextView)
        view.addSubview(jsTextView)
        view.addSubview(webView)
        view.addSubview(consoleTextView)

        [
            "V:|-[htmlTitleLabel(20)]-[htmlTextView(150)]-[jsTitleLabel(20)]-[jsTextView(80)]-[webViewTitleLabel(20)]-[webView(200)]-[consoleTitleLabel(20)]-[consoleTextView]-|",
            "H:|-[htmlTitleLabel]-|",
            "H:|-[jsTitleLabel]-|",
            "H:|-[webViewTitleLabel]-|",
            "H:|-[consoleTitleLabel]-|",
            "H:|-[htmlTextView]-|",
            "H:|-[jsTextView]-|",
            "H:|-[webView]-|",
            "H:|-[consoleTextView]-|"
        ].forEach({
            NSLayoutConstraint.activate(
                NSLayoutConstraint.constraints(
                    withVisualFormat: $0,
                    metrics: nil,
                    views: [
                        "htmlTitleLabel": htmlTitleLabel,
                        "jsTitleLabel": jsTitleLabel,
                        "webViewTitleLabel": webViewTitleLabel,
                        "consoleTitleLabel": consoleTitleLabel,
                        "htmlTextView": htmlTextView,
                        "jsTextView": jsTextView,
                        "webView": webView,
                        "consoleTextView": consoleTextView,
                    ]
                )
            )
        })

        self.view = view
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        htmlTextView.resignFirstResponder()
        jsTextView.resignFirstResponder()
    }

    func reloadWebView() {
        webView.loadHTMLString(html, baseURL: nil)
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        reloadWebView()
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript(javascript) { [weak self] result, error in
            guard let self else { return }

            self.consoleTextView.text = """
            ‣ error:
            \(String(describing: error))

            ‣ result:
            \(String(describing: result))
            """
        }
    }
}
