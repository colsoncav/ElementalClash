import SwiftUI
import WebKit
import AppKit

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black
            GameWebView()
        }
        .ignoresSafeArea()
    }
}

struct GameWebView: NSViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeNSView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        config.mediaTypesRequiringUserActionForPlayback = []
        if #available(macOS 11.0, *) {
            config.defaultWebpagePreferences.allowsContentJavaScript = true
            config.defaultWebpagePreferences.preferredContentMode = .desktop
        }

        let webView = FocusableWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.underPageBackgroundColor = .black
        webView.setValue(false, forKey: "drawsBackground")

        context.coordinator.loadGame(into: webView)
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {}
}

final class Coordinator: NSObject, WKNavigationDelegate {
    func loadGame(into webView: WKWebView) {
        guard let fileURL = Bundle.main.url(forResource: "elemental-clash-team", withExtension: "html") else {
            webView.loadHTMLString("<h1>Game file missing</h1><p>Could not find elemental-clash-team.html in app bundle.</p>", baseURL: nil)
            return
        }

        do {
            let html = try String(contentsOf: fileURL, encoding: .utf8)
            webView.loadHTMLString(html, baseURL: fileURL.deletingLastPathComponent())
        } catch {
            webView.loadFileURL(fileURL, allowingReadAccessTo: fileURL.deletingLastPathComponent())
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showError(on: webView, error: error)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        showError(on: webView, error: error)
    }

    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }

    private func showError(on webView: WKWebView, error: Error) {
        let escaped = error.localizedDescription
            .replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
        let html = """
        <html><body style="font-family:-apple-system;background:#111;color:#eee;padding:24px">
        <h2>Failed to load game</h2>
        <p>\(escaped)</p>
        </body></html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }
}

final class FocusableWebView: WKWebView {
    override var acceptsFirstResponder: Bool { true }

    override func keyDown(with event: NSEvent) {
        if event.isARepeat {
            return
        }
        super.keyDown(with: event)
    }

    override func doCommand(by selector: Selector) {
    }

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.window?.makeFirstResponder(self)
        }
    }
}

#Preview {
    ContentView()
}
