{
	match($0,/"[^"]*"$/,ua)	
	match($0,/^([0-9\.]* )([^:]*)\[([^:]*):/,ip2date)	
	print ip2date[1] ip2date[3]	
	daily_unique_ip[ip2date[1] "-" ip2date[3]]+=1 # save unique day->IP mappings	
	ua_counter[ua[0]]+=1
	nrecs+=1;
	nips[$1]+=1
	
}
END{
	print "# log entries: " nrecs 
	print "# unique IPs: " length(nips) 
	PROCINFO["sorted_in"] = "@val_type_desc"
	printf ("%15s | %s \n", "IP address", "# log entries")
	for (ipaddr in nips){
		printf("%15s | %s\n", ipaddr, nips[ipaddr])
	}
	print "\n-------------------------------\n User Agents: \n"
	printf("%s | %s\n", "# log entries", "User Agent String")
	for(user_ag in ua_counter){
		printf("%s |  %s\n", ua_counter[user_ag], user_ag)
	}
	print "\n-------------------------------\n Daily Unique IPs: \n"
	print "date | Unique IPs connected"
	for (ipdate in daily_unique_ip){
		split(ipdate, arr, " -")
		countdaily[arr[2]]+=1	
	}
	for(date in countdaily){
		printf("%10s | %s\n", date, countdaily[date]) #todo implement some kind of sorting
	}	
}

