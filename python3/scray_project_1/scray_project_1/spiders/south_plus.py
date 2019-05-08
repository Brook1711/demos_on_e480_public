# -*- coding: utf-8 -*-
import scrapy


class SouthPlusSpider(scrapy.Spider):
    name = 'south-plus'
    allowed_domains = ['white-plus.net']
    start_urls = ['http://white-plus.net/']

    def parse(self, response):
        pass
