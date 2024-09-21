//
//  NetworkError.swift
//  weatherForecast
//
//  Created by eva on 17.09.2024.
//

enum NetworkError: Error {
    case noData
    case parsingError
    case notInternet
    case responseError
    case smthWentWrong
    
    var description: String {
        switch self {
        case .noData:
            return "Нет данных"
        case .parsingError:
            return "Ошиюка парсинга данных"
        case .notInternet:
            return "Нет интернета"
        case .responseError:
            return "Неверный ответ сервера"
        case .smthWentWrong:
            return "Что-то пошло не так"
        }
    }
}
