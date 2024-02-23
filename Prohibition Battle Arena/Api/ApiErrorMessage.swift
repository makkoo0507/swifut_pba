//これら以外のエラーメッセージが表示された場合は、バックエンドで定義されたエラーメッセージ
enum apiErrorMessage {
    static let urlError = "管理者に問い合わせてください。(urlエラー)"
    static let encodeError = "管理者に問い合わせてください。(エンコードエラー)"
    static let networkError = "管理者に問い合わせてください。(ネットワークエラー)"
    static let invalidInput = "Invalid input. Please enter a valid value."
}
