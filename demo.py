from BitSrunLogin.LoginManager import LoginManager

loginDomainOrIp = "10.92.110.107"

# zs校区可以不改地址，只需要填你自己的帐号密码就行
lm = LoginManager(
	url_login_page = "http://%s/srun_portal_pc?ac_id=1&theme=zju"%loginDomainOrIp,
	url_get_challenge_api = "http://%s/cgi-bin/get_challenge"%loginDomainOrIp,
	url_login_api = "http://%s/cgi-bin/srun_portal"%loginDomainOrIp)

lm.login(
    username = "2183333333",
    password = '123456789',
)
