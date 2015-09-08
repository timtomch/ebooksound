# Test script to turn EBSCO ebook usage statistics
# (Sessions by hour report)
# into music using Sonic Pi.
# An AccessYYZ hackfest project.

require 'csv'

basefolder = "/Users/thomas/Documents/access-soundhack/ebooksound/in/sessions/"

def play_stats(statfile)
  data = CSV.parse(File.read(statfile), {:headers => true, :header_converters => :symbol})
  with_fx :reverb do
    data.each do |line|
      count = line[:count].to_f
      srch = line[:searches_average].to_f
      flltxt = line[:total_full_text].to_f
      custom = line[:custom_link].to_f
      smart = line[:smart_link_to].to_f
      for i in 0..count do
          sample :ambi_choir, rate: (count+i+1)
        end
        if srch > 0 then
          #sample :guit_em9, rate: srch/100
          synth :beep, note: srch/10+35
          if flltxt > 0 then
            #sample :ambi_glass_hum, rate: flltxt
            synth :saw, note: flltxt +70
          end
        end
        for i in 0..smart-1 do
            sample :drum_splash_hard
            sleep 0.2
          end
          for i in 0..custom-1 do
              sleep 0.1
              sample :drum_tom_hi_hard
              sleep 0.1
            end
          end
        end
      end

      # Loop through all files in base folder
      Dir.glob(basefolder+"*.csv") do |item|
        #next if item == '.' or item == '..' or item = '.*'
        print item
        play_stats(item)
      end