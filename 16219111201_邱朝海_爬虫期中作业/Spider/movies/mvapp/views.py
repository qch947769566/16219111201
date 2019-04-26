from django.shortcuts import render
import pymysql
import requests
from bs4 import BeautifulSoup

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.keys import Keys
import time
import os

# Create your views here.

#静态爬取豆瓣top250
#爬取数据，并存入数据库
def getHTMLText(url):
    try:
        res=requests.get(url,timeout=60)
        res.raise_for_status()
        res.encoding=res.apparent_encoding
        return res.text
    except:
        return "产生异常！"

def fillList(ulist,html):
    soup=BeautifulSoup(html,"html.parser")
    movies=soup.find('ol',class_="grid_view")
    if movies:
        for mv in movies.find_all('li'):
            href=mv.find('div',class_="hd").a.attrs['href']
            title=mv.find('div',class_="hd").a.span.get_text()
            quote=mv.find('p',class_="quote").span.get_text()
            ulist.append([href,title,quote])
        return ulist
    else:
        print("找不到参数！")   

def inputMysql(ulist):    #存入数据库
    conn=pymysql.connect(host='localhost',user='root',passwd='admin',db='douban',charset="utf8",cursorclass=pymysql.cursors.DictCursor)
    cur=conn.cursor()
    try:
        for i in ulist:
            cur.execute("insert into movies (链接,标题,简介) values (%s,%s,%s)",(i[0],i[1],i[2]))     
        cur.close()
        conn.commit() 
        conn.close()
        print("数据已传入数据库！")
    except:
        print("数据传输失败！")
        
def _main_():
    mv=[]
    movies=[]
    start_num=0
    for i in range(2):
        url='https://movie.douban.com/top250?start=%s&filter='%(start_num+25*i)
        html=getHTMLText(url)
        movies=fillList(mv,html)
    inputMysql(movies)

#读取数据库，展示在页面上
def get_data(sql):
    conn=pymysql.connect('localhost','root','admin','douban',port=3306,charset="utf8",cursorclass=pymysql.cursors.DictCursor)
    cur=conn.cursor()
    cur.execute(sql)
    results=cur.fetchall()
    cur.close()
    conn.close()
    return results

def Show(request):
    _main_()
    sql="select * from movies"
    movie_list=get_data(sql)
    return render(request,'douban250.html',{'Show':movie_list})
#静态爬取结束


#接下来代码为seleium动态爬取京东手机：

class JDphone():
    def Open_web(self,url,key):     #找到查询板块，模拟浏览器输入“手机”搜索手机页面
        chromedriver="D:/平时文件/爬虫/16219111201_邱朝海_爬虫期中作业/chromedriver.exe"
        os.environ["webdriver.chrome.driver"]=chromedriver
        self.driver=webdriver.Chrome(chromedriver)
        print("正在打开网页...")
        self.driver.get(url)
        keyput=self.driver.find_element_by_id("key")
        keyput.send_keys(key)
        keyput.send_keys(Keys.ENTER)

    def fillList(self,tlist):
            print("网站正在响应...")
            self.driver.implicitly_wait(3)
            for i in range(10):
                self.driver.execute_script("var q=document.documentElement.scrollTop={0}".format(i*1000))
                time.sleep(1)
            time.sleep(3)
            try:
                phone=self.driver.find_elements_by_xpath("//div[@id='J_goodsList']//li[@class='gl-item']")
                for p in phone:
                    try:
                        price=p.find_element_by_xpath(".//div[@class='p-price']//i").text
                        introduce=p.find_element_by_xpath(".//div[@class='p-name p-name-type-2']//em").text
                        brand=introduce.split(" ")[0]
                        brand=brand.replace(",","")#品牌
                        quato=introduce.replace(",","")#简介
                        evaluate_num=p.find_element_by_xpath(".//div[@class='p-commit']//strong//a").text#评价条数
                        try:#图片链接
                            img1=p.find_element_by_xpath(".//div[@class='p-img']//a//img").get_attribute("src")
                        except:
                            img1=""
                        try:
                            img2=p.find_element_by_xpath(".//div[@class='p-img']//a//img").get_attribute("data-lazy-img")
                        except:
                            img2=""
                        if img1:
                            img=img1
                        else:
                            img=img2
                        tlist.append([img,brand,price,quato,evaluate_num])
                    except:
                        print("error")
                return tlist
            except:
                print("出错")

    def nextPage(self):#翻页
        try:
            previous=self.driver.find_element_by_xpath("//span[@class='p-num']//a[@class='pn-prev disabled']")
        except:
            previous=""    
        #只有第一页的上一页按钮的class为“pn-prev disabled”，所以第一页后，previous均为空
        #第一页时，previous不为空，执行点击事件
        if previous:
            next=self.driver.find_element_by_xpath("//span[@class='p-num']//a[@class='pn-next']")
            next.click()

    def inputMysql(self,tlist): #数据库先手动建好
        print("正在传入数据库...")
        conn=pymysql.connect(host='localhost',user='root',passwd='admin',db='douban',charset="utf8",cursorclass=pymysql.cursors.DictCursor)
        cur=conn.cursor()
        try:
            for i in tlist:
                cur.execute("insert into jdphone (图片,品牌,价格,简介,评价条数) values (%s,%s,%s,%s,%s)",(i[0],i[1],i[2],i[3],i[4]))
            cur.close()
            conn.commit() 
            conn.close()
            print("数据已传入数据库！")
        except:
            print("数据传输失败！")

    def Spider(self,url,key,tlist):#运行总过程
        print("开始爬取")
        self.Open_web(url,key)
        phone1=self.fillList(tlist)
        tlist=[]
        self.nextPage()
        print("正在爬取第二页...")
        phone2=self.fillList(tlist)
        self.driver.close()
        self.inputMysql(phone1+phone2)

def JD(request):
    tlist=[]
    url="https://www.jd.com"
    phone=JDphone()
    phone.Spider(url,"手机",tlist)
    sql="select * from jdphone"
    phone_list=get_data(sql)
    return render(request,'JDphone.html',{'JD':phone_list})
#动态爬取结束


