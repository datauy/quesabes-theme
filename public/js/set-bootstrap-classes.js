$(function (){
  $('#outgoing_message_body').addClass('form-control');
  $('#upload_response_form textarea').addClass('form-control');
  $('#upload_response_form #file_1').addClass('form-control');
  $('#upload_response_form input[type=submit]').removeClass('btn-default').addClass('btn btn-success');
  $('#comment_form #comment_body').addClass('form-control');
  $('#comment_form input[type=submit]').removeClass('btn-default').addClass('btn btn-success');
  $('#incoming_message_message').addClass('form-control');
  $('#sign_alone #user_signin_email').addClass('form-control');
  $('#sign_alone #user_signin_password').addClass('form-control');
  $('#new_public_body_change_request #public_body_change_request_user_name').addClass('form-control');
  $('#new_public_body_change_request #public_body_change_request_user_email').addClass('form-control');
  $('#new_public_body_change_request #public_body_change_request_public_body_email').addClass('form-control');
  $('#new_public_body_change_request #public_body_change_request_source_url').addClass('form-control');
  $('#new_public_body_change_request #public_body_change_request_notes').addClass('form-control');
  $('#new_public_body_change_request .form_item_note').addClass('help-block');
  $('#new_public_body_change_request input[type=submit]').removeClass('btn-default').addClass('btn btn-success');
});
