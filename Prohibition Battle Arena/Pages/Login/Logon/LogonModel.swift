//
//  LogonModel.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/05.
//

import Foundation
import Combine
class LogonModel: ObservableObject {
    //フォーム項目
    @Published var name: String = ""
    @Published var birthday: Date? = nil
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    //バリデーションステータス
    @Published var errorMessage: String = ""
    @Published var isValidName: Bool = false
    @Published var isValidBirthday: Bool = true
    @Published var isValidPhone: Bool = false
    @Published var isValidEmail: Bool = false
    @Published var isValidPassword: Bool = false
    //モーダルステータス
    @Published var showBirthdayOption: Bool = false
    @Published var showSexOption: Bool = false
    
    
    @Published var userApi = UserApi()
    @Published var loginApi = LoginApi()
    private var disposables = [AnyCancellable]()
    init(){
        $name
            .removeDuplicates()
            .map { str in
                return str.count >= 1
            }
            .assign(to: &$isValidName)
        $birthday
            .removeDuplicates()
            .map { selectedDate in
                let currentDate = Date()
                if let selectedDate = selectedDate {
                    return selectedDate < currentDate
                }else{
                    return false
                }
            }
            .assign(to: &$isValidBirthday)
        $phone
            .removeDuplicates()
            .map { str in
                return str.count >= 1
            }
            .assign(to: &$isValidPhone)
        $email
            .removeDuplicates()
            .map { str in
                return str.count >= 1
            }
            .assign(to: &$isValidEmail)
        $password
            .removeDuplicates()
            .map { str in
                return str.count >= 1
            }
            .assign(to: &$isValidPassword)
    }
    func isButtonEnabled() -> Bool {
        return isValidName && isValidBirthday && isValidPhone && isValidEmail && isValidPassword
    }
    func execLogon() async {
        let createUser = User(
            name:self.name,
            phone: self.phone,
            birthday: formatDate(self.birthday),
            email:self.email,
            password:self.password
        )
        let response = await userApi.createUser(user: createUser)
        if(response.status){
            print("ログオンが成功しました")
            DispatchQueue.main.async {
                self.errorMessage = ""
                UserDefaults.standard.set(response.user?.id, forKey: "apiToken")
            }
        }else{
            print("ログオンが失敗しました")
            DispatchQueue.main.async {
                self.errorMessage = response.message ?? "予期せぬエラー"
            }
        }
    }
}
