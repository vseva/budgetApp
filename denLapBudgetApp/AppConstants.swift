//
//  AppConstants.swift
//  denLapBudgetApp
//
//  Created by Seva Denisov on 06.06.2020.
//  Copyright © 2020 Seva Denisov. All rights reserved.
//

import Foundation


struct AppConstants {
    static let apiGetEntries = "\(AppSecret.apiUri)/entries"
    static let apiAddEntry = "\(AppSecret.apiUri)/add"
    static let apiUpdateEntry = "\(AppSecret.apiUri)/update"
    static let apiRemoveEntry = "\(AppSecret.apiUri)/remove"

    enum AppTabs {
        case add, expenses, income, expensesAll, incomeAll
    }
    static let expenseEntryType = "expense"
    static let incomeEntryType = "income"
    static let expensesTitle = "Expenses"
    static let incomeTitle = "Income"
    
    static let budgetSectionTitles: [String: String] = [
        expenseEntryType: expensesTitle,
        incomeEntryType: incomeTitle,
    ]

    static let budgetEntryTypes: [String: String] = [
        expenseEntryType: "Expense",
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
    
    static let humanDateFormat = "MMM d, yyyy"
    
    static let humanMonth: [String: String] = [
        "01": "January",
        "02": "February",
        "03": "March",
        "04": "April",
        "05": "May",
        "06": "June",
        "07": "July",
        "08": "August",
        "09": "September",
        "10": "October",
        "11": "November",
        "12": "December",
    ]
}
