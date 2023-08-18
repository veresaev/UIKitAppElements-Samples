//
//  ViewController.swift
//  UIKitApp
//
//  Created by Sergey Veresaev on 17.8.23..
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var slider: UISlider!
    @IBOutlet var textField: UITextField!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var hideAllElements: UISwitch!
    @IBOutlet var switchLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup main label
        mainLabel.font = mainLabel.font.withSize(48)
        mainLabel.textAlignment = .center
        mainLabel.numberOfLines = 3
        
        // Setup segmented control
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: false)
        
        // Setup slider
        slider.value = 1
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .systemBlue
        slider.maximumTrackTintColor = .systemGreen
        slider.thumbTintColor = .white
        
        mainLabel.text = String(slider.value)
        
        // Setup button
        doneButton.layer.cornerRadius = 5
        
        // Setup Date Picker
        datePicker.locale = Locale(identifier: "ru_RU")
//        datePicker.locale = Locale.current
        
        hideAllElements.onTintColor = .red
        switchLabel.text = "Скрыть все элементы"
        
    }

    @IBAction func changeSegment() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mainLabel.text = "The first segment is selected"
            mainLabel.textColor = .systemRed
        case 1:
            mainLabel.text = "The second segment is selected"
            mainLabel.textColor = .systemBlue
        case 2:
            mainLabel.text = "The third segment is selected"
            mainLabel.textColor = .systemPurple
        default: break
        }
    }
     
    @IBAction func sliderAction() {
        let backgroundColor = view.backgroundColor
//        print(String(format: "%.1f", floor(num * 10) / 10))
        view.backgroundColor = backgroundColor?.withAlphaComponent(CGFloat(slider.value))
        mainLabel.text = String(slider.value)
    }
    @IBAction func doneButtonPressed() {
        guard let inputText = textField.text, !inputText.isEmpty else { return }
        
        if let _ = Double(inputText) {
            showAlert(title: "Wrong format!", message: "Please enter your name")
            print("Wrong format")
        } else {
            mainLabel.text = inputText
            textField.text = nil
        }
    }
    @IBAction func changeDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let dateValue = dateFormatter.string(from: datePicker.date)
        mainLabel.text = dateValue
    }
    @IBAction func switchAction() {
        segmentedControl.isHidden.toggle()
        mainLabel.isHidden.toggle()
        slider.isHidden.toggle()
        textField.isHidden.toggle()
        doneButton.isHidden.toggle()
        datePicker.isHidden.toggle()
        // Added switchAction() .toggle()
        
        switchLabel.text = hideAllElements.isOn ? "Скрыть все элементы" : "Отобразить все элементы"
    }
}

extension ViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Ok", style: .default) {
            _ in self.textField.text = ""
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
