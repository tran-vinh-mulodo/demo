class SendMail < ActionMailer::Base

  def send_mail_introduce(mail_content)
    body = get_body_of_mail(mail_content)
      mail(
	form:         ENV["GMAIL_USERNAME"],
	to:           mail_content[:email],
	subject:      mail_content[:title],
	content_type: "text/html",
	return_path:  '',
	sender:       'info',
	body:         body
	)
  end

  def get_body_of_mail(mail_content)
    body = get_content_html
    body.gsub!("_title_",mail_content[:title]) unless mail_content[:title].nil?
    body.gsub!("_name_",mail_content[:name]) unless mail_content[:name].nil?
    body.gsub!("_note_",mail_content[:note]) unless mail_content[:note].nil?
  end

  def get_content_html
    "<!DOCTYPE html>
    <html>
      <head>
	<meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
      </head>
      <body>
	<h1>_title_</h1>
	<p>
	  You have successfully signed up to example.com,
	  your username is: _name_.<br/>
	</p>
	<p>_note_</p>
      </body>
    </html>"
  end

end
