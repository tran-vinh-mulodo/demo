require 'net/smtp'
SMTP_SERVER_ERRORS = [TimeoutError,
                          IOError,
                          Net::SMTPUnknownError,
                          Net::SMTPServerBusy,
                          Net::SMTPAuthenticationError]

SMTP_CLIENT_ERRORS = [Net::SMTPFatalError, Net::SMTPSyntaxError]