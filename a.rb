require "pp"

def labels(path)
    labels = []
    File.open(path).each_line do |l|
        a = l.split(" ")
        labels << {
            video: a[0],
            shotid: a[1],
            parson: a[2],
            weight: a[3].to_f,
        }
    end
    labels
end


# 人名に対してgrouping
h = Hash.new() { |h,k| h[k] = [] }
labels("./all.late_naming.label").each do |label|
    h[label[:parson]] << label
end

h.each do |parson, v|
    label = v.max_by { |x| x[:weight] }
    puts "#{label[:parson]} #{label[:video]} #{label[:shotid]} image"
end
