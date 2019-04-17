# JAVA 와 Swift간 소켓 통신

#### Swift 5 /xcode10.2 사용.

##### (server : Java client : swift)

#### 1. cocoapod 설치

##### 1. 터미널을 열고 아래의 명령어 입력

~~~
$ sudo gem install cocoapods
~~~

##### 2. 터미널로 코코아팟 라이브러리를 사용 할 프로젝트 경로로 이동

##### 3. 프로젝트 위치에서 아래의 명령어 입력

~~~
$ pod init
~~~

 => 수행 후 프로젝트로 들어가보면 podfile이라는 파일이 나오는데 이 파일을 수정해서 원하는 라이브러리를 설치 할 수있다.

##### 4. Pod file 수정

~~~
$ open podfile
~~~

 'pods for 프로젝트 이름 ' 밑에 아래코드를 입력한다.

~~~
pod 'SwiftSocket'
~~~

저장 후 닫음.

##### 5. pod install 

~~~
$ pod install
~~~

이제부터는 **프로젝트이름.xcworkspace** 를 사용해야한다.



##### 6. Client_soket 코드 ( swift )

~~~swift
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

~~~

##### 7. 실행 앱 화면

<img src = "https://user-images.githubusercontent.com/48287388/56292926-109ea600-6163-11e9-87b8-6da638137392.png" width="300">

##### 8. 추가. java_server 코드
~~~java

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.io.IOException;
import java.util.logging.Logger;

public class test {


    private ServerSocket serverSocket;
    private Socket socket;
    private Logger logger;
    public static void main(String args[]){
        test a = new test();
        a.start();
    }

    public void start() {
        logger = Logger.getLogger(this.getClass().getName());


        try {
            serverSocket = new ServerSocket(5050);
            logger.info("Server Start");
            while (true) {
                socket = serverSocket.accept();
                logger.info("Client access");

                BufferedReader inMsg;
                inMsg = new BufferedReader(new InputStreamReader((socket.getInputStream())));
                PrintWriter outMsg = new PrintWriter(socket.getOutputStream(), true);

                String msg = inMsg.readLine();
                System.out.println(msg);
                outMsg.println("hello");
            }
        } catch (IOException e) {
            logger.info("SystemServer Exception start()");
            e.printStackTrace();
        }
    }
}
~~~
