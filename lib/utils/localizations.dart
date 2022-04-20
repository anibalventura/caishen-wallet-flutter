/*
? Helper class that access the translations in json format.
* Find the strings to translate in /assets/lang/.
*/

class LocaleTr {
  static const String appName = 'Caishen Wallet';
  static const String loading = 'loading';
  static const String save = 'save';
  static const String cancel = 'cancel';
  static const String yes = 'yes';

  // Errors.
  static const String emptyFormFieldError = 'empty_form_field_error';
  static const String completeFieldError = 'complete_field_error';
  static const String passwordsMatchError = 'passwords_match_error';

  // Login Screen.
  static const String loginEmail = 'login_email';
  static const String loginPassword = 'login_password';
  static const String loginSignIn = 'login_sign_in';
  static const String loginNoAccount = 'login_no_account';

  // Create Account Screen.
  static const String createAccount = 'create_account';
  static const String createAccountUsername = 'create_account_username';
  static const String createAccountConfirmPassword =
      'create_account_confirm_password';
      
  // Dashboard Screen.
  static const String dashboard = 'dashboard';
  static const String dashboardExpenses = 'dashboard_expenses';
  static const String dashboardIncomes = 'dashboard_incomes';

  // Transactions.
  static const String transactions = 'transactions';
  static const String dontHaveTransactions = 'dont_have_transactions';
  static const String transactionAdd = 'transaction_add';
  static const String transactionDeleteTitle = 'transaction_delete_title';
  static const String transactionDeleteMsg = 'transaction_delete_msg';
  static const String transactionDeleteSnackbar = 'transaction_delete_snackbar';
  static const String transactionExpense = 'transaction_expense';
  static const String transactionIncome = 'transaction_income';
  static const String transactionPaymentType = 'transaction_payment_type';
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

  // Profile Screen.
  static const String profileNewUsername = 'profile_new_username';
  static const String profileNewEmail = 'profile_new_email';
  static const String profileConfirmEmail = 'profile_confirm_email';
  static const String profileNewPassword = 'profile_new_password';
  static const String profileConfirmPassword = 'profile_confirm_password';
  static const String profileDeleteAccount = 'profile_delete_account';
  static const String profileDeleteAccountMsg = 'profile_delete_account_msg';

  // Settings screen.
  static const String settingsCategories = 'settings_categories';
  static const String settingsCategoriesEditSnackbar =
      'settings_categories_edit_snackbar';
  static const String settingsPaymentTypes = 'settings_payment_types';
  static const String settingsPaymentTypesEditSnackbar =
      'settings_payment_types_edit_snackbar';
}
