class ContactsController < ApplicationController
  def index
  end

  def create
    contact_name = params[:contact_name]
    email_from = params[:email_from]
    subject = params[:subject]
    contact_phone = params[:contact_phone]
    message = params[:message]

    if contact_name.blank?
      render json: {code: 300, data: "Missing your contact name"}
      return
    end
    if email_from.blank?
      render json: {code: 300, data: "Missing your email address"}
      return
    end
    if subject.blank?
      render json: {code: 300, data: "Enter your subject please"}
      return
    end
    if contact_phone.blank?
      render json: {code: 300, data: "Missing your phone number"}
      return
    end
    if message.blank?
      render json: {code: 300, data: "Enter message please"}
      return
    end

    UserMailer.inquiry_submit_email(contact_name, email_from, subject, contact_phone, message).deliver

    render json: {code: 100, data: "Succesfully sent your email!"}
    return
  end
end
