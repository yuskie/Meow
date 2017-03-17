import requests
from bs4 import BeautifulSoup
import os
import sys
import urllib


def create_pic_directory():
    cwd = os.getcwd()
    cwd += "/pics"
    if not (os.path.isdir(cwd)):
        os.makedirs(cwd)


def find_image_links(url):
    request_response = requests.get(url)
    # request_response = open(url, "r")
    soup = BeautifulSoup(request_response.text, "html.parser")
    print(soup)
    thumbnail_links = soup.select("div.link.thing")
    print(thumbnail_links)
    img_links = parse_img_links(thumbnail_links)
    return img_links


def parse_img_links(thumbnail_links):
    img_list =[]
    imgur_format_prefix = "i.imgur"
    imgur_format_suffix = ".jpg"
    for link in thumbnail_links:
        img_link = link.get("data-url")
        imgur_needs_format = "//imgur"
        if imgur_needs_format in img_link:
            img_link = img_link.replace("imgur", imgur_format_prefix)
            img_link += imgur_format_suffix
        if (not img_link.endswith(".gif") or not img_link.endswith(".gifv")) and "reddit" in img_link:
            img_list.append(img_link)
        if img_link.endswith("jpg"):
            img_list.append(img_link)
    return img_list


def save_img(img_list):
    for link in img_list:
        dir = "pics/"
        img_name = dir + link.rsplit('/', 1)[-1]
        if not img_name.endswith(".jpg"):
            img_name += ".jpg"
        request_code = requests.head(link).status_code
        if request_code >=200:
            if request_code < 300:
                urllib.urlretrieve(link, img_name)


def run(arg_list):
    create_pic_directory()
    print(arg_list[1])
    list = find_image_links(arg_list[1])
    print(list)
    save_img(list)


if __name__ == '__main__':
    run(sys.argv)
