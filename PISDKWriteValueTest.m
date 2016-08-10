%Note: AF SDK Reference located at https://techsupport.osisoft.com/Documentation/PI-AF-SDK/Html/1a02af4c-1bec-4804-a9ef-3c7300f5e2fc.htm
%to see what Methods from a .NET object that MATLAB can see, use methods()
%or methodsview(), for example: methods(AFValue); methodsview(AFValue); 

%add OSIsoft .NET references to be able to use them
NET.addAssembly('OSIsoft.AFSDK');
import OSIsoft.AFSDK.PI.*;
%import OSIsoft.PISDK.*;
%import OSIsoft.PISDK.PISDK.*;
%import OSIsoft.PISDK.PISDKCommon.*;

piservers = OSIsoft.AF.PI.PIServers;
%ListNET(piservers)
%simply grab the default server
%to get a non-default server use pisrv = piservers.Item('servername');
pisrv = piservers.DefaultPIServer;

point = PIPoint.FindPIPoint(pisrv,'p999testtag');


fprintf('The value of %s is %f at %s \n', char(point.Name), point.Snapshot.Value, char(point.Snapshot.Timestamp.LocalTime.ToString()));


newval = AFValue(33,AFTime('*'));


%note: writing to a value requires:
%write acccess to the tag, 
%and buffering to be set up
%be careful that no other sources are writing to this tag
%else you run the risk of a Postevent failed: [-11414] Buffered point does not accept new events
point.UpdateValue(newval, OSIsoft.AF.Data.AFUpdateOption.Replace);

fprintf('The new value of %s is %f at %s \n', char(point.Name), point.Snapshot.Value, char(point.Snapshot.Timestamp.LocalTime.ToString()));
