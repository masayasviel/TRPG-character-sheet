# encoding: UTF-8
require "json"

root_dir = "./skills/"
csv_array = ["academic", "action", "combat", "negotiate", "search"]

json_path = "./skills.json"

hash = {}

csv_array.each do |file_name|
    f = File.open(root_dir+file_name+".csv", "r:utf-8")
    data = f.read.split
    arr = []
    data.each do |i|
        line = i.split(",")
        arr << {
            "name" => line[0],
            "initValue" => line[1].to_i,
            "occupationPoint" => 0,
            "interestPoint" => 0,
            "fixPoint" => 0
        }
    end
    hash[file_name] = arr
    f.close
end

f = File.open(json_path, "w:utf-8")

f.print JSON.pretty_generate(hash)

f.close