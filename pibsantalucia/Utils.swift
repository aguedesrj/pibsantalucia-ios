//
//  Utils.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import Foundation

import UIKit
import SystemConfiguration
import Alamofire
import SafariServices
import AVFoundation

final class Utils {
    
    static var kTransitionFadeImage: TimeInterval = 0.1
    static var messageSystemUnavailable: String = "Sistema indisponível no momento, tente mais tarde!"
    static var failureConnectedToNetwork: String = "Verifique sua conexão com a internet."
    static var dateFormatDDMMYYYY: String = "dd/MM/yyyy"
    static var dateFormatDDMMYYYYHHMM: String = "dd/MM/yyyy HH:mm"
    static var kLoading: String = "Carregando..."
    
    class func dialToPhoneNumber(_ phoneNumber: String) {
        let set = NSCharacterSet(charactersIn: "0123456789").inverted
        let cleanedString = phoneNumber.components(separatedBy: set).reduce("", { $0 + $1 })
        let phone = "tel://" + cleanedString
        if let url = URL(string: phone) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    class func validDateCreditCards(dateString: String) -> Bool {
        if dateString.count != 5 {
            return false
        }
        let arrayDate = dateString.components(separatedBy: "/")
        
        let newDateString: String = "20\(arrayDate[1])-\(arrayDate[0])-01T00:00"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        let date: Date? = dateFormatter.date(from: newDateString)
        
        return dateFormatter.date(from: newDateString) == nil
    }
    
    class func convertFromStringToDate(dateString: String, format: String) throws -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = format
        let date: Date? = dateFormatter.date(from: dateString)
        return date!
    }
    
    class func convertFromDateToString(date: Date?, format: String) -> String {
        if (date == nil) {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "pt_BR")
        let returnDate: String = dateFormatter.string(from: date!)
        return returnDate
    }
    
    class func isNotConnectedToNetwork() -> Bool {
        if NetworkReachabilityManager()!.isReachable {
            return false
        }
        return true
    }
    
    class func getMonthAbbreviated(month: Int) -> String {
        switch month {
        case 1:
            return "JAN"
        case 2:
            return "FEV"
        case 3:
            return "MAR"
        case 4:
            return "ABR"
        case 5:
            return "MAI"
        case 6:
            return "JUN"
        case 7:
            return "JUL"
        case 8:
            return "AGO"
        case 9:
            return "SET"
        case 10:
            return "OUT"
        case 11:
            return "NOV"
        default:
            return "DEZ"
        }
    }
    
    class func layputViewTextField(view: UIView, textField: UITextField) {
        textField.textColor = Color.primary.value
        textField.tintColor = Color.primary.value
        
        self.layputView(view: view)
    }
    
    class func layputView(view: UIView) {
        view.layer.cornerRadius = 8.0
        view.backgroundColor = Color.primary.value
    }
    
    class func layoutCell(view: UIView) {
        view.layer.cornerRadius = 8.0
        view.layer.borderColor = Color.primary.value.cgColor
        view.layer.borderWidth = 2.0
        
        self.shadowBottom(view: view)
    }
    
    class func layoutButton(button: UIButton) {
        button.setTitleColor(Color.primary.value, for: .normal)
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = Color.primary.value.cgColor
        button.layer.borderWidth = 2.0
        button.backgroundColor = UIColor.white
        
        self.shadowBottom(view: button)
    }
    
    class func shadowBottom(view: UIView) {
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 3.0
        view.layer.shadowColor = Color.blackWithAlpha16.value.cgColor
    }
    
    class func specificFormattingDate(dateString: String, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = format
        let date: Date? = dateFormatter.date(from: dateString)
        
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date!)
        let month = myCalendar.component(.month, from: date!)
        let day = myCalendar.component(.day, from: date!)
        
        //Quarta-feira 24 de Julho
        return "\(getDayWeekDescription(dayWeek: weekDay)) \(day) DE \(getMonthDescription(month: month))"
    }
    
    class func getDayWeekDescription(dayWeek: Int) -> String {
        switch dayWeek {
        case 1:
            return "DOMINGO"
        case 2:
            return "SEGUNDA-FEIRA"
        case 3:
            return "TERÇA-FEIRA"
        case 4:
            return "QUARTA-FEIRA"
        case 5:
            return "QUINTA-FEIRA"
        case 6:
            return "SEXTA-FEIRA"
        default:
            return "SÁBADO"
        }
    }
    
    class func getDayWeekAbbreviated(dayWeek: Int) -> String {
        switch dayWeek {
        case 1:
            return "DOM"
        case 2:
            return "SEG"
        case 3:
            return "TER"
        case 4:
            return "QUA"
        case 5:
            return "QUI"
        case 6:
            return "SEX"
        default:
            return "SÁB"
        }
    }
    
    class func getMonthDescription(month: Int) -> String {
        switch month {
        case 1:
            return "JANEIRO"
        case 2:
            return "FEVEREIRO"
        case 3:
            return "MARÇO"
        case 4:
            return "ABRIL"
        case 5:
            return "MAIO"
        case 6:
            return "JUNHO"
        case 7:
            return "JULHO"
        case 8:
            return "AGOSTO"
        case 9:
            return "SETEMBRO"
        case 10:
            return "OUTUBRO"
        case 11:
            return "NOVEMBRO"
        default:
            return "DEZEMBRO"
        }
    }
    
    class func removePhoneFormat(number:String) -> String {
        return number.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "")
    }
    
    class func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    class func generateIdForDay(date: String) -> Int {
        var generateId = date.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range:nil)
        if generateId.count < 8 {
            generateId = "9\(generateId)"
        }
        return Int(generateId)!
    }
    
    class func generateIdForHour(hour: String) -> Int {
        var generateId = hour.replacingOccurrences(of: ":", with: "", options: NSString.CompareOptions.literal, range:nil)
        if generateId.count < 4 {
            generateId = "9\(generateId)"
        }
        return Int(generateId)!
    }
    
    class func typeFileAnnexImage(extensionFile: String) -> Bool {
        if extensionFile.uppercased() == "PNG" ||
            extensionFile.uppercased() == "JPG" ||
            extensionFile.uppercased() == "JPEG" {
            
            return true
        }
        return false
    }
    
    class func typeFileAnnexImageDesc(extensionFile: String) -> String {
        if typeFileAnnexImage(extensionFile: extensionFile) {
            return "IMAGEM"
        }
        return "DOCUMENTO"
    }
    
    class func callSafariViewController(viewController: UIViewController, url: String) {
        let urlString: String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let safariVC = SFSafariViewController(url: NSURL(string: urlString)! as URL)
        viewController.present(safariVC, animated: true, completion: nil)
    }
    
    class func convertValueMoney(value: Float) -> String {
        let valueString: String = "\(value)"
        if valueString.count == 0 {
            return valueString
        }
        
        let arrayValue = valueString.components(separatedBy: ".")
        if arrayValue.count == 1 {
            return "\(arrayValue[0]),00"
        }
        
        if arrayValue[1].count == 1 {
            return "\(arrayValue[0]),\(arrayValue[1])0"
        }
        return "\(arrayValue[0]),\(arrayValue[1])"
    }
    
    class func checkPermissionCameraAndMicrophone() -> Bool {
        return checkPermissionCamera() && checkPermissionMicrophone()
    }
    
    class func checkPermissionCamera() -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return true
        default:
            return false
        }
    }
    
    class func checkPermissionMicrophone() -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized:
            return true
        default:
            return false
        }
    }
}
