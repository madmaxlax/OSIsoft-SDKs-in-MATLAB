%Note: AF SDK Reference located at https://techsupport.osisoft.com/Documentation/PI-AF-SDK/Html/1a02af4c-1bec-4804-a9ef-3c7300f5e2fc.htm
%to see what Methods from a .NET object that MATLAB can see, use methods()
%or methodsview(), for example: methods(AFValue); methodsview(AFValue); 

%add OSIsoft .NET references to be able to use them
NET.addAssembly('OSIsoft.AFSDK');
import OSIsoft.AF.*;
import OSIsoft.AF.Time.*;
import OSIsoft.AF.PI.*;
%import OSIsoft.PISDK.*;
%import OSIsoft.PISDK.PISDK.*;
%import OSIsoft.PISDK.PISDKCommon.*;

piservers = OSIsoft.AF.PI.PIServers;
%ListNET(piservers)
%simply grab the default server
pisrv = piservers.DefaultPIServer;
%to get a non-default server use pisrv = piservers.Item('servername');

%get the PI Point sinusoid
point = PIPoint.FindPIPoint(pisrv,'sinusoid');

timest = AFTime('*-1h'); %1 hour ago
value = point.InterpolatedValue(timest).Value;
%get the single interpolated value 1 hour ago


timerg = AFTimeRange('*-1d','*'); %set up variable to be a time range of yesterday to right now
inter = AFTimeSpan(0,0,0,1); %constructor to create a time interval of 1 hour
%get the interpolated 1 hr values from the past day for sinusoid
values = point.InterpolatedValues(timerg, inter, '', true); 
%not that this is returned as a .NET <List> of AFValues, which MATLAB can't do much with

%so we have to user this custom function ListNETValues to get it into a matlab friendly cell array
arrayofVals = ListNETValues(values);
display(arrayofVals);
%fprintf('The value of %s is %f at %s \n', char(point.Name), point.InterpolatedValue(timest), char(point.Snapshot.Timestamp.LocalTime.ToString()));


