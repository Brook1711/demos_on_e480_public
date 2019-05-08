# -*- coding: utf-8 -*-
import scrapy


class ChinadailySpider(scrapy.Spider):
    name = 'chinadaily'
    allowed_domains = ['chinadaily.com.cn']
    start_urls = ['http://newssearch.chinadaily.com.cn/rest/en/search?keywords=fantastic&sort=dp&page=0&curType=story&type=&channel=&source=']

    def parse(self, response):
        print(type(response))
        print(response.body)


