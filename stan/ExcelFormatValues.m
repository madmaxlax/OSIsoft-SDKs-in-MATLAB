function [ forExcel ] = ExcelFormatValues( PIValuesPage )
%EXCELFORMATVALUES Summary of this function goes here
%   Detailed explanation goes here
% takes in PIValuesPage variable and splits it up and returns it
%in an excel /Datalink style of formatting
%  time |  tag 1 | tag 2 | tag 3 ...
% [date]|  val1  | val 2 | val3
% [date]|  val1  | val 2 | val3
% ...
    
    %returnCellArray = {'Timestamps'};
    
    key_enum = PIValuesPage.GetEnumerator;
    %len = NETListItem.Count;
    count = 1;
    status = 1;
    forExcel = {};
    %loop through "pages" of tags with values
    while status 
       status = key_enum.MoveNext;
       if status
           %get tag's set of values
           tagValues = key_enum.Current;
           %if there are tags
           if ~isempty(tagValues)
            values_key_enum = tagValues.GetEnumerator;
            %start at 2 leave room for tag name
            values_counter = 2;
            values_stat = 1;
            values_stat = values_key_enum.MoveNext;
            values_key_val = values_key_enum.Current;
            len = tagValues.Count;
            if count == 1 
                %leave room for timestamp
                values_list = cell(len+1,2);
                values_list(1,1) = cellstr('Timestamps');
                values_list(1,2) = cellstr(char(values_key_val.PIPoint.Name));
            else 
                %just list of values
                values_list = cell(len+1,1);
                %tag name up top
                values_list(1) = cellstr(char(values_key_val.PIPoint.Name));
            end
            
            %loop through values of a tag
            while values_stat 
               if values_stat
                   if ~isempty(values_key_val)
                       %NOTE: assumes the item has the property Name (which the OSIsoft ones do)
                       tagvalue = num2str(values_key_val.Value);
                       timestmp = char(values_key_val.Timestamp.LocalTime.ToString());
                       if count ==1 
                           values_list(values_counter,1:2) = {timestmp, tagvalue}; 
                       else
                           values_list(values_counter) = {tagvalue};
                       end
                        values_stat = values_key_enum.MoveNext;
                        values_key_val = values_key_enum.Current;
                        values_counter = values_counter +1;
                   end
               end
            end
            %add tag and values to big excel array
            forExcel = [forExcel values_list];
           end
       end
       count = count +1;
    end
    
    lax = 3;
end

