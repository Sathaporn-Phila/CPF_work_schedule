# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
=begin
['งานถอนขน','งานไก่ตกราว','งานเชือดไก่','งานจัดเก็บและจ่ายสินค้าแช่แข็ง'].each do |department|
    Sector.create(in_department: 0,department_name:department)
end
=end
for hour in (0..23) do
    @start_min = 00
    for min in (1..2) do
        if hour < 10
            if @start_min == 0
                start_work = "0"+((hour%24).to_s)+"H"+"0"+(@start_min%60).to_s
            else
                start_work = "0"+((hour%24).to_s)+"H"+(@start_min%60).to_s
            end
        else
            if @start_min == 0
                start_work = ((hour%24).to_s)+"H"+"0"+(@start_min%60).to_s
            else
                start_work = +((hour%24).to_s)+"H"+(@start_min%60).to_s
            end
        end
        if (hour+9)%24 < 10
            if @start_min == 0
                end_work = "0"+(((hour+9)%24).to_s)+"H"+"0"+(@start_min%60).to_s
            else
                end_work = "0"+(((hour+9)%24).to_s)+"H"+(@start_min%60).to_s
            end
        else
            if @start_min == 0
                end_work = (((hour+9)%24).to_s)+"H"+"0"+(@start_min%60).to_s
            else
                end_work = (((hour+9)%24).to_s)+"H"+(@start_min%60).to_s
            end
        end
        start_work_in_time = (start_work.sub 'H',':').to_time
        end_work_in_time = (end_work.sub 'H',':').to_time
        start_breaktime = start_work_in_time + 4.hours
        end_breaktime = end_work_in_time.to_time - 4.hours
        Shiftcode.create(code_name:(start_work+"-"+end_work),start_in:start_work_in_time,end_in:end_work_in_time,start_break:start_breaktime,end_break:end_breaktime,work_time:8)
        @start_min+=30
    end
end