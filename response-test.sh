curl -s -w 'Testing Website Response Time for: %{url_effective}\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}\nPre-transfer Time:\t%{time_pretransfer}\nStart-transfer Time:\t%{time_starttransfer}\nAppcon Time:\t\t%{time_appconnect}\nRedirect Time:\t\t%{time_redirect}\n\nTotal Time:\t\t%{time_total}\n' -o /dev/null luculliano.ru > webspeedtest_"$(date)"
echo "https://www.techrepublic.com/article/how-to-test-website-speeds-curl/"