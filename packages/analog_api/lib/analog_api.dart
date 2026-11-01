// Generated code - do not modify by hand
// ignore_for_file: lines_longer_than_80_chars

/// Cafe Analog CoffeeCard API
/// Version v2
/// ASP.NET Core WebAPI for Cafe Analog
///
/// Contact: AnalogIO
/// Email: support@analogio.dk
/// URL: https://github.com/analogio
///
/// License: Use under MIT
/// License URL: https://github.com/AnalogIO/analog-core/blob/master/LICENSE
///
/// Security Schemes:
/// - HTTP Bearer: JWT Bearer token
///   Format: JWT
/// - API Key (header): Api Key used for health endpoints

library;

export 'src/api_client/account_api.dart';
export 'src/api_client/admin_statistics_api.dart';
export 'src/api_client/app_config_api.dart';
export 'src/api_client/health_api.dart';
export 'src/api_client/leaderboard_api.dart';
export 'src/api_client/menu_items_api.dart';
export 'src/api_client/products_api.dart';
export 'src/api_client/programmes_api.dart';
export 'src/api_client/purchases_api.dart';
export 'src/api_client/receipt_api.dart';
export 'src/api_client/statistics_api.dart';
export 'src/api_client/tickets_api.dart';
export 'src/api_client/vouchers_api.dart';
export 'src/api_client/webhooks_api.dart';
export 'src/model/account_user_group.dart';
export 'src/model/add_menu_item_request.dart';
export 'src/model/add_product_request.dart';
export 'src/model/api_error.dart';
export 'src/model/api_v2_leaderboard_top_get200_body_model.dart';
export 'src/model/api_v2_menuitems_get200_body_model.dart';
export 'src/model/api_v2_products_all_get200_body_model.dart';
export 'src/model/api_v2_products_get200_body_model.dart';
export 'src/model/api_v2_programmes_get200_body_model.dart';
export 'src/model/api_v2_purchases_get200_body_model.dart';
export 'src/model/api_v2_purchases_user_user_id_get200_body_model.dart';
export 'src/model/api_v2_statistics_quick_get200_body_model.dart';
export 'src/model/api_v2_statistics_unused_clips_post200_body_model.dart';
export 'src/model/api_v2_tickets_get200_body_model.dart';
export 'src/model/api_v2_tickets_grouped_get200_body_model.dart';
export 'src/model/api_v2_vouchers_issue_vouchers_post200_body_model.dart';
export 'src/model/app_config.dart';
export 'src/model/complete_registration_request.dart';
export 'src/model/email_exists_request.dart';
export 'src/model/email_exists_response.dart';
export 'src/model/environment_type.dart';
export 'src/model/free_purchase_payment_details.dart';
export 'src/model/grouped_tickets_response.dart';
export 'src/model/initiate_purchase_request.dart';
export 'src/model/initiate_purchase_response.dart';
export 'src/model/initiate_purchase_response_payment_details_one_of_model.dart';
export 'src/model/issue_voucher_request.dart';
export 'src/model/issue_voucher_response.dart';
export 'src/model/leaderboard_entry.dart';
export 'src/model/leaderboard_preset.dart';
export 'src/model/login_type.dart';
export 'src/model/menu_item_response.dart';
export 'src/model/message_response_dto.dart';
export 'src/model/mobile_pay_payment_details.dart';
export 'src/model/mobile_pay_payment_details_model.dart';
export 'src/model/payment_details.dart';
export 'src/model/payment_type.dart';
export 'src/model/product_response.dart';
export 'src/model/profile_background_color.dart';
export 'src/model/profile_icon.dart';
export 'src/model/programme_response.dart';
export 'src/model/purchase_receipt.dart';
export 'src/model/purchase_receipt_model.dart';
export 'src/model/purchase_status.dart';
export 'src/model/quick_stat_response.dart';
export 'src/model/quick_stat_type.dart';
export 'src/model/receipt_base.dart';
export 'src/model/receipt_response.dart';
export 'src/model/receipt_response_receipts_array_one_of_model.dart';
export 'src/model/receipt_type.dart';
export 'src/model/register_account_request.dart';
export 'src/model/resend_account_verification_email_request.dart';
export 'src/model/service_health_response.dart';
export 'src/model/simple_purchase_response.dart';
export 'src/model/simple_user_response.dart';
export 'src/model/single_purchase_response.dart';
export 'src/model/single_purchase_response_payment_details_one_of_model.dart';
export 'src/model/ticket_response.dart';
export 'src/model/token_login_request.dart';
export 'src/model/unused_clips_request.dart';
export 'src/model/unused_clips_response.dart';
export 'src/model/update_menu_item_request.dart';
export 'src/model/update_product_request.dart';
export 'src/model/update_user_group_request.dart';
export 'src/model/update_user_request.dart';
export 'src/model/use_ticket_request.dart';
export 'src/model/used_ticket_receipt.dart';
export 'src/model/used_ticket_receipt_model.dart';
export 'src/model/used_ticket_response.dart';
export 'src/model/user_group.dart';
export 'src/model/user_login_request.dart';
export 'src/model/user_login_response.dart';
export 'src/model/user_response.dart';
export 'src/model/user_role.dart';
export 'src/model/user_search_response.dart';
export 'src/model/user_state.dart';
export 'src/model/voucher_receipt.dart';
export 'src/model/voucher_receipt_model.dart';
export 'src/model/webhook_update_user_group_request.dart';
export 'src/response_wrapper/account_authenticate_response.dart';
export 'src/response_wrapper/account_complete_registration_response.dart';
export 'src/response_wrapper/account_delete_response.dart';
export 'src/response_wrapper/account_email_exists_response.dart';
export 'src/response_wrapper/account_get_response.dart';
export 'src/response_wrapper/account_login_response.dart';
export 'src/response_wrapper/account_register_response.dart';
export 'src/response_wrapper/account_resend_verification_email_response.dart';
export 'src/response_wrapper/account_search_users_response.dart';
export 'src/response_wrapper/account_update_account_user_group_response.dart';
export 'src/response_wrapper/account_update_response.dart';
export 'src/response_wrapper/admin_statistics_get_unused_clips_response.dart';
export 'src/response_wrapper/health_healthcheck_response.dart';
export 'src/response_wrapper/leaderboard_get_response.dart';
export 'src/response_wrapper/menu_items_add_menu_item_response.dart';
export 'src/response_wrapper/menu_items_get_all_menu_items_response.dart';
export 'src/response_wrapper/menu_items_update_menu_item_response.dart';
export 'src/response_wrapper/products_add_product_response.dart';
export 'src/response_wrapper/products_get_product_response.dart';
export 'src/response_wrapper/products_get_products_response.dart';
export 'src/response_wrapper/purchases_get_all_purchases_for_user_response.dart';
export 'src/response_wrapper/purchases_get_all_purchases_response.dart';
export 'src/response_wrapper/purchases_get_purchase_response.dart';
export 'src/response_wrapper/purchases_initiate_purchase_response.dart';
export 'src/response_wrapper/purchases_refund_purchase_response.dart';
export 'src/response_wrapper/statistics_get_quick_stats_response.dart';
export 'src/response_wrapper/tickets_get_grouped_owned_tickets_response.dart';
export 'src/response_wrapper/tickets_get_response.dart';
export 'src/response_wrapper/tickets_use_ticket_response.dart';
export 'src/response_wrapper/vouchers_issue_vouchers_response.dart';
export 'src/response_wrapper/vouchers_redeem_voucher_response.dart';
export 'src/response_wrapper/webhooks_update_user_groups_response.dart';
export 'src/server/server.dart';
