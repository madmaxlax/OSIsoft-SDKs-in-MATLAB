%Note: AF SDK Reference located at https://techsupport.osisoft.com/Documentation/PI-AF-SDK/Html/1a02af4c-1bec-4804-a9ef-3c7300f5e2fc.htm
%to see what Methods from a .NET object that MATLAB can see, use methods()
%or methodsview(), for example: methods(AFValue); methodsview(AFValue); 

%add OSIsoft .NET references to be able to use them
NET.addAssembly('OSIsoft.AFSDK');
import OSIsoft.AF.PI.*;
%import OSIsoft.PISDK.*;
%import OSIsoft.PISDK.PISDK.*;
%import OSIsoft.PISDK.PISDKCommon.*;

piservers = OSIsoft.AF.PI.PIServers;
%ListNET(piservers)
%simply grab the default server
%to get a non-default server use pisrv = piservers.Item('servername');
pisrv = piservers.DefaultPIServer;

point = PIPoint.FindPIPoint(pisrv,'Sinusoid');


fprintf('The value of %s is %f at %s \n', char(point.Name), point.Snapshot.Value, char(point.Snapshot.Timestamp.LocalTime.ToString()));


%or find multiple points
points = PIPointList(PIPoint.FindPIPoints(pisrv,'Sinu*'));
%output them
display(ListNET(points.Snapshot())) %listNET is a custom function in another file in this project 
