{
	match($0,/"[^"]*"$/,ua)	
	#match($0,/^\/[^\/]*\//,ip2date)	
	#print ip2date[0]	
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

}

