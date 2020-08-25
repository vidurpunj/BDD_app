# ActionMailer::Base.smtp_settings = {
#     address:              "mail.tukatech.com",
#     port:                 465,
#     domain:               "tukatech.com",
#     authentication:       :login,
#     tls:                  true,
#     user_name:            "tukacloud@tukatech.com",
#     password:             "e~7V@3rGn",
#     :enable_starttls_auto => true,
#     :openssl_verify_mode  => 'none'
# }

ActionMailer::Base.smtp_settings = {
		address: "smtp.gmail.com",
		port: 587,
		domain: "gmail.com",
		user_name: "vidur.tukatech@gmail.com",
		password: "vidur.tukatech2018",
		authentication: "plain",
		enable_starttls_auto: true
}
