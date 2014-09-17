class ExportController < ApplicationController
  include ScheduleHelper
  def index
  end
  
  def start
    scheduler = ScheduleUtil.singleton
    scheduler.every '2s' do
      mail = {
        email: "luong.phuc@mulodo.com",
        title: "Wellcome Minh Phuc!",
        name:  "Minh Phuc",
        note:  "Have a nice day"
      }
      (0..1000).each do |i|
        #SendMail.send_mail_introduce(mail).deliver!
        puts "chay ne dai ca #{i}"
      end  
    end
    render :text => 'Start Schedule'
  end
  
  def kill
    scheduler = ScheduleUtil.singleton
    scheduler.stop()
    render :text => 'Kill Schedule'
  end

  def send_mail
    if params["email"].nil? || params["email"] == ""
      flash[:error] = "invalid_params"
      render :json => flash.to_json
      return false
    end
      mail = {
        email: params["email"],
        title: "Wellcome Minh Phuc!",
        name:  "Minh Phuc",
        note:  "Have a nice day"
      }
      begin
        SendMail.send_mail_introduce(mail).deliver!
      rescue *SMTP_SERVER_ERRORS => error
        flash[:error] = "SMTP_SERVER_ERRORS"
        render :json => flash.to_json
        return false
      rescue *SMTP_CLIENT_ERRORS => error
        flash[:error] = "SMTP_CLIENT_ERRORS"
        render :json => flash.to_json
        return false
      end
    flash[:notice] = "SUCCESSFUL"
    render :json => flash.to_json
  end

  def run_resque
    begin
      #Resque.enqueue_at(5.days,SnippetHighlighter, {email: "luong.phuc@mulodo.com",authenticity_token: form_authenticity_token})
      Resque.enqueue(SnippetHighlighter, {email: "luong.phuc@mulodo.com",authenticity_token: form_authenticity_token})
    rescue Exception => e
      flash[:error] = "Please start Redis before run... #{e.message} "
      redirect_to export_index_path
      return false
    end
    flash[:notice] = "Resque is running"
    redirect_to export_index_path
  end

  def run_schedule
    if params["email"].nil? || params["email"] == ""
      redirect_to export_index_path
      return false
    end
    ScheduleHelper::Schedule_rufu.create_schedule(params["email"],{email: params["email"],authenticity_token: form_authenticity_token})
    flash[:notice] = "Number schedule : #{ScheduleHelper::Schedule_rufu.view_list_schedule}"
    redirect_to export_index_path
  end

  def del_schedule
    if params["email"].nil? || params["email"] == ""
      flash[:notice] = "Number schedule : #{ScheduleHelper::Schedule_rufu.view_list_schedule}"
      redirect_to export_index_path
      return false
    end
    ScheduleHelper::Schedule_rufu.del_schedule(params["email"])
    flash[:notice] = "Number schedule : #{ScheduleHelper::Schedule_rufu.view_list_schedule}"
    redirect_to export_index_path
  end

end