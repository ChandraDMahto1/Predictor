import random
import requests
import urllib
from bs4 import BeautifulSoup

def house_spider(max_pages):
    page=15000
    while page <= max_pages:
        url ='http://www.fotosearch.com/photos-images/house_'+str(page)+'.html'
        #print(url)
        source_code=requests.get(url)
        plain_text = source_code.text
        #print(plain_text)
        soup = BeautifulSoup(plain_text)
        for link in soup.findAll('a',{'class':''}):
            href='http://www.fotosearch.com'+link.get('href')
            srf=link.get('href')
            #title = link.string
            #print(href)
            get_image(srf)
            #print(titlhrefe)
        page+=1

def get_image(srf):
    name=random.randrange(1,16386)
    full_name = str(name) + ".jpg"
    my_string = srf.rstrip('/')
    url= 'http://fscomps.fotosearch.com/compc/CSP' + my_string + ".jpg"
   # print (url)
    urllib.request.urlretrieve(url,full_name)

#http://fscomps.fotosearch.com/compc/CSP/CSP971/k9717538.jpg
#http://fscomps.fotosearch.com/compc/CSP/CSP172/k1728020.jpg



house_spider(16386)
