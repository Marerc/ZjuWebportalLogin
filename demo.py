from BitSrunLogin.LoginManager import LoginManager

# zs校区可以不改地址，只需要填你自己的帐号密码就行
lm = LoginManager(
	url_login_page = "http://10.92.110.107/srun_portal_pc?ac_id=1&theme=zju",
	url_get_challenge_api = "http://10.92.110.107/cgi-bin/get_challenge",
	url_login_api = "http://10.92.110.107/cgi-bin/srun_portal")

lm.login(
    username = "2183333333",
    password = '123456789',
)
