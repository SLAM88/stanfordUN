	require 'open-uri'
	require 'nokogiri'
	require 'pdf-reader'
	require 'csv'

	# EXAMPLE URL http://unscr.com/files/1946/00001.pdf
	base = "http://unscr.com/files/"
	years = *(1946..2014)

	yearCounter = 0
	resolutions = *(1..2165)
	resCounter = 1

	FirstResOfYear = [   16,   38,   67,   79,   90,   97,   99,  104,  106,  111,  122,  127,  132,  133,  161,  171,  178,  186,  200,  220,  233,  245,  263,  276,  292,  308,  325,  345,  367,  385,  403,  423,  444,  462,  485,  500,  529,  546,  560,  581,  594,  607,  627,  647,  684,  726,  800,  893,  970, 1036, 1093, 1147, 1220, 1285, 1335, 1387, 1455, 1522, 1581, 1652, 1739, 1795, 1860, 1908, 1967, 2033, 2086, 2133, 2166]


	local_fname = "output.csv"
	File.open(local_fname, 'a')

	resolutions.each do |i|
		URL = base + "%d" % years[yearCounter] + "/" + "%05d" % i + ".pdf"
		resCounter = resCounter + 1
		if FirstResOfYear.include? resCounter
			yearCounter = yearCounter + 1
		end
		puts URL
	io = open(URL)
	reader = PDF::Reader.new(io)

	reader.pages.each do |page|
		text = page.text.gsub("\n", '')
		text = text.split.join(" ")
		if text.include? "all necessary means"
			File.open(local_fname, 'a'){|file| file.write("%d" % years[yearCounter] + ", " "%05d" % i + ", all necessary means" + "\n")}
			puts "%d" % years[yearCounter] + ", " "%05d" % i + ", all necessary means"
		end
		if text.include? "all necessary measures"
			File.open(local_fname, 'a'){|file| file.write("%d" % years[yearCounter] + ", " "%05d" % i + ", all necessary measures" + "\n")}
			puts "%d" % years[yearCounter] + ", " "%05d" % i + ", all necessary measures"
		end
		if text.include? "Chapter VII"
			File.open(local_fname, 'a'){|file| file.write("%d" % years[yearCounter] + ", " "%05d" % i + ", Chapter VII" + "\n")}
			puts "%d" % years[yearCounter] + ", " "%05d" % i + ", Chapter VII"
		end
	end

	Object.instance_eval{ remove_const :URL }
	sleep 0.5 + rand

end