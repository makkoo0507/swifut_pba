//
//  ProfileEditModel.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/02/05.
//

import Foundation
import Combine
class ProfileEditModel: ObservableObject {
    @Published var userId: Int = 0
    //フォーム項目
    @Published var name: String = "no name"
    @Published var birthday: Date = Date()
    @Published var originalUserBirthday: Date = Date()
    @Published var sex: String = "その他"
    //バリデーションステータス
    @Published var isValidName: Bool = false
    @Published var isValidBirthday: Bool = false
    @Published var isValidSex: Bool = false
    @Published var isButtonEnabled: Bool = false
    @Published var errorMessage: String = ""
    //モーダルステータス
    @Published var showSexOption: Bool = false
    @Published var showBirthdayOption: Bool = false
    //ロードステータス
    @Published var userApi = UserApi()
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
                let validCondition = selectedDate < currentDate
                return validCondition
            }
            .assign(to: &$isValidBirthday)
        $sex
            .removeDuplicates()
            .map { str in
                return str.count >= 1
            }
            .assign(to: &$isValidSex)
        Publishers.CombineLatest3($isValidName, $isValidBirthday, $isValidSex)
            .map { isValidName, isValidBirthday, isValidSex in
                return isValidName && isValidBirthday && isValidSex
            }
            .assign(to: &$isButtonEnabled)
    }
    
    func setObject(user:User){
        self.userId = user.id ?? 0
        self.name = user.name ?? ""
        self.birthday = parseDate(user.birthday ?? "1000-01-01", format: "yyyy-MM-dd") ?? Date()
        self.sex = user.sex ?? "その他"
    }
    
    func updateUser() async {
        let updateUser = User(
            name: name,
            birthday: formatDate(birthday),
            sex: sex
        )
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
