#!/usr/bin/env ruby

# Pull territories translation data from CLDR

require 'nokogiri'

Dir["data/cldr_1.9/common/main/**/*"].each do |data_file|
  file_content = File.open(data_file) { |f| f.read.strip }
  language_code = data_file.split('/').last.split('.').first
  file = File.open("territories/#{language_code}.yml", 'w+')
  file.puts "#{language_code}:"
  doc = Nokogiri::XML(file_content)
  doc.search('//territory').each do |xml_ter|
    code = xml_ter.get_attribute('type')
    file.puts "  \"#{xml_ter.get_attribute('type')}\": \"#{xml_ter.text}\""
    puts xml_ter.get_attribute('type') + ": #{xml_ter.text}"
  end
end
