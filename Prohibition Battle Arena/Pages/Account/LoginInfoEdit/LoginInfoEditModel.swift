//
//  LoginInfoEditViewModel.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/04.
//

import Foundation
import Combine
class LoginInfoEditModel: ObservableObject {
    //項目
    @Published var isChangePassword: Bool = false
    @Published var userId: Int = 0
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    //バリデーションチェック
    @Published var isValidPhone: Bool = false
    @Published var isValidEmail: Bool = false
    @Published var isValidPassword: Bool = false
    @Published var isButtonEnabled: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var userApi = UserApi()
    private var disposables = [AnyCancellable]()
    init(){
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
        Publishers.CombineLatest4($isChangePassword,$isValidPhone, $isValidEmail, $isValidPassword)
            .map {isChangePassword, isValidPhone, isValidEmail, isValidPassword in
                if(isChangePassword){
                    return isValidPhone && isValidEmail && isValidPassword
                }else{
                    return isValidPhone && isValidEmail
                }
            }
            .assign(to: &$isButtonEnabled)
    }
    
    func setLoginInfo(user:User){
        self.userId = user.id ?? 0
        self.phone = user.phone ?? ""
        self.email = user.email ?? ""
        self.password = user.password ?? ""
    }
    
    
    func updateUser() async {
        var updateUser = User(phone: phone,
                              email: email)
        if(isChangePassword){
            updateUser.password = password
        }
        let response = await userApi.updateUser(userId: userId, user: updateUser)
        if(response.status){
            print("ログイン情報の更新が成功しました")
            DispatchQueue.main.async {
                self.errorMessage = ""
            }
        }else{
            print("ログイン情報の更新が失敗しました")
            DispatchQueue.main.async {
                self.errorMessage = response.message ?? "予期せぬエラー"
            }
        }
    }
}
