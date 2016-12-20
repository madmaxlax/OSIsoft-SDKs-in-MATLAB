# OSIsoft-SDKs-in-MATLAB
Examples of using the OSIsoft PI SDK and AF SDK in MATLAB

Open the various .m MATLAB files for the examples

**Examples included in this**

 1. Using the PISDK, get a point's current value https://github.com/madmaxlax/OSIsoft-SDKs-in-MATLAB/blob/master/PISDKGetValueTest.m
   - PISDK to get interpolated values at set intervals in a given time range
   https://github.com/madmaxlax/OSIsoft-SDKs-in-MATLAB/blob/master/PIDownload.m
 2. Using PISDK *write* a value to a PI point https://github.com/madmaxlax/OSIsoft-SDKs-in-MATLAB/blob/master/PISDKWriteValueTest.m
 3. AFSDK get an Attribute value https://github.com/madmaxlax/OSIsoft-SDKs-in-MATLAB/blob/master/AFSDKGetValueTest.m
 4. AFSDK *write* an attribute value https://github.com/madmaxlax/OSIsoft-SDKs-in-MATLAB/blob/master/AFSDKWriteTest.m

Some helpful info:

**.NET in MATLAB**

 - http://nl.mathworks.com/help/matlab/matlab_external/access-a-simple-net-class.html
 - viewing the methods available on a .NET object in MATLAB http://nl.mathworks.com/help/matlab/ref/methodsview.html

**OSIsoft Info**

 - PI and MATLAB White Paper https://pisquare.osisoft.com/docs/DOC-1305
 - **New!(( an Actual MATLAB utility for PI https://pisquare.osisoft.com/docs/DOC-2293 which replaces the need for the SDK direct references 


*Note*: the ListNET is a helper function, as MATLAB doesn't really provide a way to show the string names of a non-standard object array
