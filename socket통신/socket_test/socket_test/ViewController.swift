import UIKit
import SwiftSocket
class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    let host = "192.168.0.3"
    let port = 5050
    var client: TCPClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        client = TCPClient(address: host, port: Int32(port))
    }
    @IBAction func sendButtonAction(_ sender: Any) {
        guard let client = client else { return }
        switch client.connect(timeout: 10) {
        case .success:
            appendToTextField(string: "Connected to host \(client.address)")
            if let response = sendRequest(string: "hihi\n", using: client) {
                appendToTextField(string: "Response: \(response)")
            }
        case .failure(let error):
            appendToTextField(string: String(describing: error))
        }
    }
    private func sendRequest(string: String, using client: TCPClient) -> String? {
        appendToTextField(string: "Sending data ... ")
        switch client.send(string: string) {
        case .success:
            print("success")
            return readResponse(from: client)
        case .failure(let error):
            appendToTextField(string: String(describing: error))
            return nil
        }
    }
    private func readResponse(from client: TCPClient) -> String? {
        guard let response = client.read(1024*10, timeout: 1) else {return nil}
        return String(bytes: response, encoding: .utf8)
    }
    
    private func appendToTextField(string: String) {
        print(string)
        textView.text = textView.text.appending("\n\(string)")
    }
}
