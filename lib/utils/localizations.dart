/*
? Helper class that access the translations in json format.
* Find the strings to translate in /assets/lang/.
*/

class LocaleTr {
  static const String appName = 'Caishen Wallet';
  static const String loading = 'loading';
  static const String save = 'save';
  static const String cancel = 'cancel';

  // Errors.
  static const String emptyFormFieldError = 'empty_form_field_error';
  static const String completeFieldError = 'complete_field_error';

  // Login Screen.
  static const String loginEmail = 'login_email';
  static const String loginPassword = 'login_password';
  static const String loginSignIn = 'login_sign_in';
  static const String loginNoAccount = 'login_no_account';

  // Dashboard Screen.
  static const String dashboard = 'dashboard';

  // Transactions.
  static const String transactions = 'transactions';
  static const String dontHaveTransactions = 'dont_have_transactions';
  static const String transactionExpense = 'transaction_expense';
  static const String transactionIncome = 'transaction_income';
  static const String transactionPayment = 'transaction_payment';
  static const String paymentCash = 'payment_cash';
  static const String paymentCreditCard = 'payment_credit_card';
  static const String paymentDebitCard = 'payment_debit_card';
  static const String paymentBankTransfer = 'payment_bank_transfer';
  static const String paymentOther = 'payment_other';
  static const String transactionCategory = 'transaction_category';
  static const String categoryFoodDrinks = 'category_food_drinks';
  static const String categoryShopping = 'category_shopping';
  static const String categoryTransport = 'category_transport';
  static const String categoryEntertainment = 'category_entertainment';
  static const String categoryHealthFitness = 'category_health_fitness';
  static const String categoryPersonalCare = 'category_personal_care';
  static const String categoryHouse = 'category_house';
  static const String categoryInvestment = 'category_investment';
  static const String categoryVehicle = 'category_vehicle';
  static const String categoryEducation = 'category_education';
  static const String categoryOther = 'category_other';
  static const String transactionDateTime = 'transaction_date_time';
  static const String datePickerSelectDate = 'date_picker_selectDate';
  static const String datePickerSelect = 'date_picker_select';
  static const String transactionDescription = 'transaction_description';

  // More Screen.
  static const String more = 'more';
  static const String moreProfile = 'more_profile';
  static const String profileSignOut = 'profile_sign_out';
  static const String moreSettings = 'more_settings';
  static const String moreAbout = 'more_about';
}
