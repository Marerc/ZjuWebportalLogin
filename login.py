from BitSrunLogin.LoginManager import LoginManager
import argparse

# author: lfe
# mail: kyui#zju.edu.cn 请替换#为@

def main():
    parser = argparse.ArgumentParser(description="argparser")
    parser.add_argument('-doi','--loginDomainOrIp', default="10.92.110.107")
    parser.add_argument('-u','--username')
    parser.add_argument('-p','--password')
    args = parser.parse_args()
    # print(args)

    if (args.username != None) & (args.password != None):
        lm = LoginManager(
          url_login_page = "http://%s/srun_portal_pc?ac_id=1&theme=zju"%args.loginDomainOrIp,
          url_get_challenge_api = "http://%s/cgi-bin/get_challenge"%args.loginDomainOrIp,
          url_login_api = "http://%s/cgi-bin/srun_portal"%args.loginDomainOrIp)

        lm.login(
            username = args.username,
            password = args.password,
        )
    else:
        print("请输入账户名和(或)密码！！！")

if __name__ == '__main__':
    main()