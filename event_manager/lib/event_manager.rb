require "csv"
require 'google/apis/civicinfo_v2'
require "erb"
require "date"
require "time"

def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)

    civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
    civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

    begin
        legislators = civic_info.representative_info_by_address(
        address: zipcode,
        levels: 'country',
        roles: ['legislatorUpperBody', 'legislatorLowerBody']
        ).officials
    rescue
        'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
    end
end

def thank_you_letter(id,form_letter)
    Dir.mkdir("output") unless Dir.exists?("output")

    filename = "output/thanks_#{id}.html"

    File.open(filename,"w") do |file|
        file.write(form_letter)
    end
end

def clean_phone_number(number)
    clean_number = number.delete!("^0-9")
    if clean_number.length == 10
        clean_number
    elsif clean_number.length == 11 && clean_number[0] == 1
        clean_number = clean_number[1..-1]
    else 
        "No number available"
end

def booking_times(file)
    hours = Hash.new(0)
    days = Hash.new(0)
    file.each_with_index do |line,index|
        next if index == 0
        newline = line.split
        hour = Time.strptime(newline[1], "%m/%d/%y/%k:%M").hour
        datum = Time.parse(Time.strptime(newline[1], "%m/%d/%y/%k:%M").strftime("%y-%m-%d"))
        hours[hour] += 1
        days[datum.strftime("%A")] += 1
    end

    highest_d = days.sort_by {|key, value| value}.reverse.first
    highest_h = hours.sort_by {|key,value| value}.reverse.first

    puts "Most bookings on #{highest_d[0]}s 
    and between #{highest_h[0]} and #{highest_h[0]+1} o'clock"
end

puts "Event Manager initialized"

contents = CSV.open(
    "event_attendees.csv",
    headers: true,
    header_converters: :symbol)

template_letter = File.read("form_letter.erb")
erb_template = ERB.new(template_letter)

contents.each do |row|
    id = row[0]
    name = row[:first_name]
    number = row[:HomePhone]
    zipcode = clean_zipcode(row[:zipcode])

    legislators = legislators_by_zipcode(zipcode)

    form_letter = erb_template.result(binding)

    thank_you_letter(id,form_letter)

end
