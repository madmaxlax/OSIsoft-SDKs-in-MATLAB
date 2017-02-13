%script to run through stanislav's functions
%Note: AF SDK Reference located at https://techsupport.osisoft.com/Documentation/PI-AF-SDK/Html/1a02af4c-1bec-4804-a9ef-3c7300f5e2fc.htm

display('Starting PI Data Retrieval. Connecting to PI server...');
%add the previous directory of functions to be accessible
addpath(genpath('..'));

%add the OSIsoft .net classes
NET.addAssembly('OSIsoft.AFSDK');
import OSIsoft.AF.*;
import OSIsoft.AF.Data.*;
import OSIsoft.AF.Time.*;
import OSIsoft.AF.PI.*;

%simply grab the default server
piservers = OSIsoft.AF.PI.PIServers;
pisrv = piservers.DefaultPIServer;
display(['Connected to ' char(pisrv.Name)]);

%get list of tags to get data for from a text file
tagsList = importdata('tags.csv');
display(['Found ' num2str(size(tagsList,1)) ' tags in file']);
piPointsList  = PIPointList();
for k = 1:size(tagsList,1)
   try
    point = PIPoint.FindPIPoint(pisrv,char(tagsList(k))); 
    piPointsList.Add(point);
   catch Err
    warning(Err.message);
   end
end

display(['Found ' num2str(piPointsList.Count) ' of the  tags on the server']);


%get start and end times from a text file
timesList = importdata('startendtimesinterval.csv');
%check that only two lines
if size(timesList,1) ~= 3 || size(timesList,2) ~= 1
    error('Input Error:\nstartendtimesinterval.csv file must contain extactly 3 lines; the start time and end time and interval, as a string.\n Found %i',size(timesList,1));
end

%set up the start and end time variables
startTime = AFTime(char(timesList(1)));
endTime = AFTime(char(timesList(2)));
display(['Start time read in as  ' char(timesList(1)) ' interpreted as ' char(startTime.LocalTime.ToString())]);
display(['End time read in as  ' char(timesList(2)) ' interpreted as ' char(endTime.LocalTime.ToString())]);
%interval = AFTimeSpan();
%AFTimeSpan.TryParse(char(timesList(3)),interval); %constructor to create a time interval of 1 hour
% /10000000 /60
interval = AFTimeSpan(0,0,0,1); %constructor to create a time interval of 1 hour

timeRange = AFTimeRange(startTime,endTime);

%struct for calculation type, 2 =  average, 32 = stddev,
%more https://techsupport.osisoft.com/Documentation/PI-AF-SDK/Html/T_OSIsoft_AF_Data_AFSummaryTypes.htm
summaryType = AFSummaryTypes.Average;
calcBasis = AFCalculationBasis.TimeWeighted;
calcTimestampType = AFTimestampCalculation.Auto;

config = PIPagingConfiguration(PIPageType.TagCount, 100);%PIPageType.EventCount

%PI Data Retrival
tStart = tic;
display(['getting PI data from server']);
%values = piPointsList.InterpolatedValues(timeRange,interval,'',true,config);
values = piPointsList.Summaries(timeRange, interval, summaryType, calcBasis, calcTimestampType,config);

tElapsed = toc(tStart);
display(['took ' num2str(tElapsed) ' seconds']);
display(['converting PI data to array']);
tStart = tic;
%ListAFValues(values);
%forExcel = ExcelFormatValues(values);
forExcel = ExcelFormatValuesForSummaries(values);
tElapsed = toc(tStart);
display(['took ' num2str(tElapsed) ' seconds']);


%----
filename = ['\\Europe.shell.com\europe\Oil products\Shell Global Solutions\Proj_05\Hydrotreating\Pidata\Matlab\OSIsoft-SDKs-in-MATLAB\stan\output-files\data written' strrep(datestr(now),':','-')];
%filename = ['\\AMSDC1-NA-V509\maxwell.c.struever$\Cached\My Documents\MATLAB\stan\output-files\data written' strrep(datestr(now),':','-')];
display(['writing to excel file ' filename]);

tStart = tic;
[excelswritestatus, excelswritemessage] = xlswrite(filename, forExcel);
display(['done writing to Excel, status: ' num2str(excelswritestatus) excelswritemessage.identifier excelswritemessage.message]);
tElapsed = toc(tStart);
display(['took ' num2str(tElapsed) ' seconds']);


lax = 3;


