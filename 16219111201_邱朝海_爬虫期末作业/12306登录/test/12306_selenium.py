import re
import requests
import base64
import time
import os
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.action_chains import ActionChains

class YZlogin():

    def getImg(self):
        #构造请求头
        headers = {'User-Agent':
        'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36'
        }

        Xq_url = 'https://kyfw.12306.cn/passport/captcha/captcha-image64'
        #构造请求表单
        Xq_parmas = {
            "login_site": "E",
            "module": "login",
            "rand": "sjrand",
            "1559721131663":"",
            "callback": "jQuery19109087628126888729_1559721117999",
            "_": "1559721118001",
        }

        #创建sess对象 保持会话一至
        sess = requests.session()

        #对图片页发送请求
        response = sess.get(url=Xq_url,params=Xq_parmas,headers=headers).text
        #获取图片数据
        image_bs64 = re.findall('"image":"(.*?)",',response)[0]
        #解码数据
        image = base64.b64decode(image_bs64)
        #保存图片
        with open('Yz_image.jpg','wb') as f:
            f.write(image)
        

    def YZ_result(self):
        #验证部分交给了http://littlebigluo.qicp.net:47720/
        Xq_url1 = 'http://littlebigluo.qicp.net:47720/'
        sess1=requests.session()
        response=sess1.post(url=Xq_url1,data={"type":"1"},files={'pic_xxfile':open('Yz_image.jpg','rb')})
        result=[]
        #print(response.text)
        try:
            for i in re.findall("<B>(.*)</B>",response.text)[0].split(" "):
	            result.append(int(i))
        except:
            print("该验证网站在开小差...")

        #构建像素表单
        self.coord_data =[[-105,-20],[-35,-20],[40,-20],[110,-20],[-105,50],[-35,50],[40,50],[110,50]]
        # answerlist = []
        # #循环输入的值取出字典相应的坐标
        # for i in result:
        #     answerlist.append(coord_data[str(i)])
        # print('坐标为：' + ';'.join(answerlist))
        # #answer = ','.join(answerlist)
        self.result=result
    
    def login(self):
        Login_url="https://kyfw.12306.cn/otn/resources/login.html"
        chromedriver="D:/平时文件/爬虫/12306登录/test/chromedriver.exe"
        os.environ["webdriver.chrome.driver"]=chromedriver
        self.driver=webdriver.Chrome(chromedriver)
        print("正在打开网页...")
        self.driver.get(Login_url)
        self.img_element =WebDriverWait(self.driver, 100).until(EC.presence_of_element_located((By.ID, "J-loginImg")))
        account=self.driver.find_element_by_class_name("login-hd-account active")
        account.click()
        userName=self.driver.find_element_by_id("J-userName")
        userName.send_keys("qch947769566")
        password=self.driver.find_element_by_id("J-password")
        password.send_keys("0qiu1chao2hai3")

    def YZ_click(self):
        try:
            Action=ActionChains(self.driver)
            for i in self.result:
                Action.move_to_element(self.img_element).move_by_offset(self.coord_data[i][0],self.coord_data[i][1]).click()
            Action.perform()
        except:
            print("验证出错")

    def load(self):
        self.login()
        time.sleep(3)
        self.getImg()
        time.sleep(3)
        self.YZ_result()
        time.sleep(3)
        self.YZ_click()
        time.sleep(3)
        self.driver.find_element_by_id("J-login").click()
        time.sleep(50)

if __name__=="__main__":
    test=YZlogin()
    test.load()
