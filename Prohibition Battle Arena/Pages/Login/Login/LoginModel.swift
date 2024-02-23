//
//  LoginViewModel.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/04.
//

import Foundation
import Combine
class LoginModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var userApi = UserApi()
    //バリデーションステータス
    @Published var isValidPassword: Bool = false
    @Published var isValidEmail: Bool = true
    @Published var isButtonEnabled: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var loginApi = LoginApi()
    private var disposables = [AnyCancellable]()
    init(){
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
        Publishers.CombineLatest($isValidEmail, $isValidPassword)
            .map { isValidName, isValidPassword in
                return isValidName && isValidPassword
            }
            .assign(to: &$isButtonEnabled)
    }
    func execLogin () async {
        let respons = await loginApi.execLogin(email: email, password: password)
        if(respons.status){
            print("ログインが成功しました")
            DispatchQueue.main.async {
                UserDefaults.standard.set(respons.user?.id , forKey: "apiToken")
            }
        }else{
            errorMessage = respons.message ?? "予期せぬエラー"
            print("ログインが失敗しました")
        }
    }
}
