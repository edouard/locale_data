#!/usr/bin/env ruby

# Pull language translations data from CLDR

require 'nokogiri'

Dir["data/cldr_1.9/common/main/**/*"].each do |data_file|
  file_content = File.open(data_file) { |f| f.read.strip }
  language_code = data_file.split('/').last.split('.').first
  file = File.open("languages/#{language_code}.yml", 'w+')
  file.puts "#{language_code}:"
  doc = Nokogiri::XML(file_content)
  doc.search('//language').each do |xml_lang|
    code = xml_lang.get_attribute('type')
    file.puts "  #{code}: #{xml_lang.text}"
    puts code + "  #{code}: #{xml_lang.text}"
  end
end

