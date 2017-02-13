function [ ret ] = ListNETValues( NETListItem , includeTagName)
%LIST helper function for displaying .NET list names
%   Detailed explanation goes here

    key_enum = NETListItem.GetEnumerator;
    len = NETListItem.Count;
    cnt = 1;
    stat = 1;
    if includeTagName
        ret = cell(len,2);
    else
        ret = cell(len,3);
    end
    while stat
       stat = key_enum.MoveNext;
       if stat
           key_val = key_enum.Current;
           if ~isempty(key_val)
               %NOTE: assumes the item has the property Name (which the OSIsoft ones do)
               tagvalue = num2str(key_val.Value);
               timestmp = char(key_val.Timestamp.LocalTime.ToString());
               if includeTagName
                   try
                    tagname = key_val.Name;   
                   catch
                       tagname = char(key_val.PIPoint.Name);
                   end
                   ret(cnt,1:3) = {tagname, tagvalue, timestmp}; 
               else
                   ret(cnt,1:2) = {tagvalue, timestmp};
               end
               cnt = cnt+1;
           end
        end
    end

end