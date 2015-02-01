module Puppet::Parser::Functions
    newfunction(:maven_to_link, :type => :rvalue
    ) do |args|
      link=args[0]
      build_link=link.clone
      link.include?("SNAPSHOT") ? version='snapshots' : version='releases'
      link.include?("war") ? findextension='war</a>' : findextension='jar</a>'
      link.include?("war") ? extension='war' : extension='jar'
     # debug("link="+link)
     # debug("extension="+extension)
      tmp = link.split(':')
      build_link="https://oss.sonatype.org/content/repositories/#{version}/"
      build_link="#{build_link}#{tmp[0].gsub('.','/')}/#{tmp[1]}/"
     if version== 'snapshots'
     
      # debug("2-------rrrrrr------")
      	temp = link.scan(/\d.\d.\d-#{version.upcase.slice(0..-2)}/)
     	temp = temp.map(&:inspect).join('').slice(1..-2)
      	build_link="#{build_link}#{temp}/"
	  #	debug("2bis build_link="+build_link)
      	http = `wget #{build_link} -O -`
      	
      	grep = http.split("\n").grep(/#{findextension}/)
      	i=0
      #	debug("http=("+http+")")
      	grep.each do |truc|
        	grep[i]=truc.scan(/\d.\d.\d-\d\d\d\d\d\d\d\d.\d\d\d\d\d\d-\d+/).map(&:inspect).join('')
        	supp = (grep[i].length - 50) /2
       #     debug("grep[i]="+grep[i]+" i="+i.to_s)
        	grep[i]=truc.scan(/\d.\d.\d-\d\d\d\d\d\d\d\d.\d\d\d\d\d\d-\d+/).map(&:inspect).join('').slice!(1..23 + supp)
        	i+=1
      	end
      	grep=grep.uniq

      	num=grep.clone

      	i=0
      	num.each do |trac|
      	#    debug("trac="+trac)
        	num[i]=trac.delete(".").delete("-")
        	i+=1
     	end

      	retval="#{build_link}#{tmp[1]}-#{grep[num.index(num.max)]}.#{extension}"
      else
          retval="#{build_link}/#{tmp[2]}/#{tmp[1]}-#{tmp[2]}.#{extension}"
       end 
       retval
    end
    
end
