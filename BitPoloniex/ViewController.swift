//
//  ViewController.swift
//  BitPoloniex
//
//  Created by Burhanuddin Sunelwala on 2/2/19.
//  Copyright © 2019 burhanuddin353. All rights reserved.
//

import UIKit
import Starscream

class ViewController: UITableViewController {

    @IBOutlet private weak var switchViewSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var textField: UITextField!

    private var socket = WebSocket(url: URL(string: "wss://api2.poloniex.com")!, protocols: ["chat"])
    private var currencyPairIDs = Constant.currencyPairIDs
    private var lastTradePrice = [Int: Double]()
    private var ticker: Ticker?

    override func viewDidLoad() {
        super.viewDidLoad()

        socket.delegate = self
        socket.connect()
    }

    deinit {
        socket.disconnect(forceTimeout: 0)
        socket.delegate = nil
    }
}

// MARK: - IBActions
extension ViewController {

    @IBAction func switchViewDidChangeValue(_ segmentedControl: UISegmentedControl) {
        tableView.reloadData()
    }

    @IBAction private func dismiss(_ barButton: UIBarButtonItem) {
        performSegue(withIdentifier: "UnwindSegueToLoginViewController", sender: self)
    }
}

// MARK: - WebSocketDelegate
extension ViewController : WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        socket.write(string: "{\"command\": \"subscribe\", \"channel\": 1002}")
    }

    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {

    }

    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {

        guard let data = text.data(using: .utf8) else { return }
        guard let jsonData = try? JSONSerialization.jsonObject(with: data) else { return }
        guard let jsonArray = jsonData as? [Any], jsonArray.count > 2 else { return }
        guard let tickerDetails = jsonArray[2] as? [Any] else { return }

        ticker = try? Ticker(response: tickerDetails)
        tableView.reloadData()
    }

    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
    }
}

// MARK: - TableView Delegate & DataSource
extension ViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyPairIDs.keys.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let allKeys = Array(currencyPairIDs.keys)
        let key = allKeys[indexPath.row]
        if let ticker = ticker, key == ticker.currencyPairID {
            lastTradePrice[key] = ticker.lastTradePrice
        }

        var cell: UITableViewCell
        if switchViewSegmentedControl.selectedSegmentIndex == 0 {

            cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")!
            if let lastPrice = lastTradePrice[key] {

                cell.textLabel?.text = String(lastPrice)
                if let text = textField.text, !text.isEmpty {
                    if lastPrice > Double(text)! {
                        cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "UpArrowGreen"))
                    } else {
                        cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "DownArrowRed"))
                    }
                } else {
                    cell.accessoryView = nil
                }
            } else {
                cell.accessoryView = nil
                cell.textLabel?.text = ""
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "SecondaryCell")!
            cell.accessoryView = nil

            if let lastPrice = lastTradePrice[key] {

                cell.textLabel?.text = String(lastPrice)
                if let text = textField.text, !text.isEmpty {
                    if lastPrice > Double(text)! {
                        cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                    } else {
                        cell.backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
                    }
                } else {
                    cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }
            } else {
                cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.textLabel?.text = ""
            }
        }


        cell.detailTextLabel?.text = currencyPairIDs[key]
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Trading Data"
    }
}

// MARK: - TextField Delegate
extension ViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.reloadData()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.endEditing(true)
        return true
    }
}

