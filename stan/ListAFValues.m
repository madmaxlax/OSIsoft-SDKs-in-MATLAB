function [ ret ] = ListAFValues( NETListItem )
%LIST helper function for displaying .NET list names
%   Detailed explanation goes here

    key_enum = NETListItem.GetEnumerator;
    %len = NETListItem.Count;
    cnt = 1;
    stat = 1;
    ret = {{},{}};
    while stat
       stat = key_enum.MoveNext;
       if stat
           key_val = key_enum.Current;
           if ~isempty(key_val)
               %NOTE: assumes the item has the property Name (which the OSIsoft ones do)
               %tagvalue = key_val.Value;
               AFVals = ListNETValues(key_val,true);
               display(AFVals);
               %timestmp = char(key_val.Timestamp.LocalTime.ToString());
               %ret(cnt,1:2) = {tagvalue, timestmp};
               cnt = cnt+1;
           end
        end
    end

end