import urllib.request
import webbrowser

print("WHO'S THAT POKEMON ? ")
webUrl = urllib.request.urlopen('https://www.youtube.com/watch?v=EE-xtCF3T94&ab_channel=Shaunpants')
webbrowser.open('https://www.youtube.com/watch?v=EE-xtCF3T94&ab_channel=Shaunpants')
#print("result code: " + str(webUrl.getcode()))