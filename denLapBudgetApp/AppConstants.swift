//
//  AppConstants.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 06.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import Foundation


struct AppConstants {
    enum AppTabs {
        case expenses, add, income
    }
    static let expenseEntryType = "expense"
    static let incomeEntryType = "income"
    static let budgetEntryTypes: [String: String] = [
        expenseEntryType: "Expense",
        incomeEntryType: "Income",
    ]
    static let budgetSectionTitles: [String: String] = [
        expenseEntryType: "Expenses",
        incomeEntryType: "Income",
    ]
    static let budgetEntryTypesList: [String] = [
        expenseEntryType,
        incomeEntryType,
    ]
    
    static let natashaEntryOwnerType = "natasha"
    static let sevaEntryOwnerType = "seva"
    static let budgetEntryOwnerTypes: [String: String] = [
        natashaEntryOwnerType: "Наташа",
        sevaEntryOwnerType: "Сева",
    ]
    static let budgetEntryOwnersList: [String] = [
        natashaEntryOwnerType,
        sevaEntryOwnerType,
    ]
    
    static let apiUri = "http://localhost:3000/api"
    //static let apiUri = "https://den-lap-budget-api.now.sh/api"
    static let apiGetEntries = "\(apiUri)/entries"
    static let apiAddEntry = "\(apiUri)/add"
    static let apiRemoveEntry = "\(apiUri)/remove"
    static let apiAuthCookie = "auth=zitugtK15KhCK2X0I7d436L3dsT6AIKI2we0UsIw"
    
    static let defaultBudgetExpenseCategory = "food"
    static let budgetExpensesCategoriesList: [String] = [
        "food",
        "zhenyaHealth",
        "health",
        "mortgage",
        "municipal",
        "treasuryBox",
        "beauty",
        "credit",
        "smoking",
        "clothingAndShoes",
        "gifts",
        "travel",
        "entertainment",
        "telecom",
        "cheeze",
        "home",
        "transport",
        "digital",
        "reading",
        "electronic",
        "alcohol",
        "zhenyaHygiene",
        "deliciaes",
        "others",
        "zhenyaFood",
        "officeFood",
    ]
    static let budgetExpensesCategoriesTypes: [String: String] = [
        "alcohol": "Алкоголь",
        "zhenyaHygiene": "Гигиена Жени",
        "deliciaes": "Деликатесы",
        "others": "Другое",
        "zhenyaFood": "Еда Жени",
        "officeFood": "Еда в офисе",
        "food": "Еда",
        "zhenyaHealth": "Здоровье Жени",
        "health": "Здоровье",
        "mortgage": "Ипотека",
        "municipal": "Коммуналка",
        "treasuryBox": "Копилка",
        "beauty": "Красота",
        "credit": "Кредит",
        "smoking": "Курение",
        "clothingAndShoes": "Одежда/обувь",
        "gifts": "Подарки",
        "travel": "Путешествия",
        "entertainment": "Развлечения",
        "telecom": "Связь",
        "cheeze": "Сыр",
        "home": "Товары для дома",
        "transport": "Транспорт",
        "digital": "Цифровые услуги",
        "reading": "Чтение",
        "electronic": "Электроника",
    ]
    
    static let defaultBudgetIncomeCategory = "salary"
    static let budgetIncomeCategoriesList: [String] = [
        "avito",
        "salary",
        "treasuryBox",
        "gifts",
        "allowance",
        "interest",
        "freelance",
    ]
    static let budgetIncomeCategoriesTypes: [String: String] = [
        "avito": "Авито",
        "salary": "Зарплата",
        "treasuryBox": "Копилка",
        "gifts": "Подарки",
        "allowance": "Пособие",
        "interest": "Проценты",
        "freelance": "Фриланс",
    ]
}
