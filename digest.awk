{
	match($0,/"[^"]*"$/,ua)	
	match($0,/^([0-9\.]* )([^:]*)\[([^:]*):/,ip2date)	
	ip = ip2date[1]
        split(ip2date[3],ddmmmyyyy,"/")
	#convert date conforming to ISO-8601
	isodate = ddmmmyyyy[3] "-" monToNum(ddmmmyyyy[2]) "-" ddmmmyyyy[1]
	isomonth = ddmmmyyyy[3] "-" monToNum(ddmmmyyyy[2])
	#if ip-date-pair has not been counted, count, else add to array
	count_daily_unique_ip[isodate] += (1 - ((ip isodate) in daily_unique_ip))
	daily_unique_ip[ip isodate] += 1 
	#same for month	
	count_monthly_unique_ip[isomonth] += (1 - ((ip isomonth) in monthly_unique_ip))
	monthly_unique_ip[ip isomonth] += 1
	total_unique_ip[ip]+=1
	ua_counter[ua[0]]+=1
	nrecs+=1;
}
END{
	print "# log entries: " nrecs 
	print "# unique IPs: " length(total_unique_ip) 
	PROCINFO["sorted_in"] = "@val_type_desc"
	printf ("%16s | %s \n", "IP address", "# log entries")
	for (ipaddr in total_unique_ip){
		printf("%16s | %s\n", ipaddr, total_unique_ip[ipaddr])
	}
	print "\n-------------------------------\n User Agents: \n"
	printf("%6s | %s\n", "# log entries", "User Agent String")
	for(user_ag in ua_counter){
		printf("%6s |  %s\n", ua_counter[user_ag], user_ag)
	}
	print "\n-------------------------------\n Daily Unique IPs: \n"
	print "Date       | Unique IPs connected"
	#print daily unique ips
	for(isodate in count_daily_unique_ip){
		printf("%-10s | %d", isodate, count_daily_unique_ip[isodate])
	}
	print "\n-------------------------------\n Monthly Unique IPs:"
	#count up unique ips and sort by month
	print "Date       | Unique IPs connected"
	for(isomonth in count_monthly_unique_ip){
		printf("%-10s | %d\n", isomonth, count_monthly_unique_ip[isomonth])
	}
}

function monToNum(mon){
        split("Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec",months,",")
        for(i in months){
                if (months[i] == mon){
                       return sprintf("%02d", i)
                }
        }
}

