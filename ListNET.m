function [ ret ] = ListNET( NETListItem )
%LIST helper function for displaying .NET list names
%   Detailed explanation goes here

    key_enum = NETListItem.GetEnumerator;
    len = NETListItem.Count;
    cnt = 1;
    stat = 1;
    ret = cell(len,1);
    while stat
       stat = key_enum.MoveNext;
       if stat
           key_val = key_enum.Current;
           if ~isempty(key_val)
               %NOTE: assumes the item has the property Name (which the OSIsoft ones do)
               fullname = char(key_val.Name);
               ret{cnt} = [ret{cnt} fullname];
               cnt = cnt+1;
           end
        end
    end

end

