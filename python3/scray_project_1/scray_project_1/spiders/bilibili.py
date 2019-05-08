# -*- coding: utf-8 -*-
import scrapy


class BilibiliSpider(scrapy.Spider):
    name = 'bilibili'
    allowed_domains = ['npr.org']
    start_urls = ['https://www.npr.org/search?query=china&page=1']

    def parse(self, response):
        ret1 = response.xpath("//div[@class='storyInfo noimg']").extract()
        print(ret1)
