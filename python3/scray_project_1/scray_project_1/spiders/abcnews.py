# -*- coding: utf-8 -*-
import scrapy


class AbcnewsSpider(scrapy.Spider):
    name = 'abcnews'
    allowed_domains = ['go.com']
    start_urls = ['https://abcnews.go.com/search?searchtext=japan']

    def parse(self, response):
        print(response.body)
