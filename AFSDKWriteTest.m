%Note: AF SDK Reference located at https://techsupport.osisoft.com/Documentation/PI-AF-SDK/Html/1a02af4c-1bec-4804-a9ef-3c7300f5e2fc.htm
%to see what Methods from a .NET object that MATLAB can see, use methods()
%or methodsview(), for example: methods(AFValue); methodsview(AFValue); 

%add OSIsoft .NET references to be able to use them
NET.addAssembly('OSIsoft.AFSDK');
import OSIsoft.AF.*;
import OSIsoft.AF.Asset.*;
import OSIsoft.AF.Time.*;
import OSIsoft.AF.Data.*;
import OSIsoft.AF.PI.*;

%connect to the STCA AF Server
piSystems = OSIsoft.AF.PISystems;
fprintf('Connecting and refreshing\n');
af_server = piSystems.Item('STCA AF Server');
af_database = af_server.Databases.Item('STCA-AF');

%make sure you have the latest database
af_database.Refresh();
fprintf('Connected\n');

%get a test element 
%NOTE: this assumes that \Test\Test1|TestTag exists in the hierarchy
testAttribute = af_database.Elements.Item('Test').Elements.Item('Test1').Attributes.Item('TestTag');

%get current value data
curVal = testAttribute.GetValue();

%note char() is required for matlab to handle .NET Strings
fprintf('The value of %s is %f at %s \n', char(testAttribute.Name), curVal.Value, char(curVal.Timestamp.LocalTime.ToString()));

%set up a new value 
%note: writing to a value requires:
%write acccess to the tag, and buffering to be set up
newval = AFValue(33,AFTime('*'));

%set the value in AF
testAttribute.SetValue(newval);
af_database.ApplyChanges();
af_database.CheckIn();

%get current value data
af_database.Refresh();
newVal = testAttribute.GetValue();

%note char() is required for matlab to handle .NET Strings
fprintf('The new value of %s is %f at %s \n', char(testAttribute.Name), newVal.Value, char(newVal.Timestamp.LocalTime.ToString()));
lax = 3;
