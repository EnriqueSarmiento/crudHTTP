THIS TEST PROJECT WORKS WITH A CUSTOK API WITH PHP. 

##1. HTTP -> HTPPS
- Swift and/or XCODE only works by default with https request. therefore, in order to work with a localhost development API it is important to make some changes. 
   
   a. Go to info.plist and add a new key called App Transport Security Settings (Directory type). 
   b. in this item we cand add more rows, we need to find one called Allow Arbitary Loads and we assign the value os YES. 
   c. This will allow our local development to function with not secure URLS. It is crucial tu remember that after deter development, when try to submit to apple connect, we need to disable this feature. 
   d. After this change, the info.plist file will appear on the directory. 
   e. 
   
   
   
