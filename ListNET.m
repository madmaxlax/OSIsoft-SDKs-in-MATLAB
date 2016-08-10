function [ ret ] = ListNET( NETListItem )
%LIST Summary of this function goes here
%   Detailed explanation goes here

    %keys = dic.Keys;
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
               %assumes the item has the property Name
               fullname = char(key_val.Name);
               ret{cnt} = [ret{cnt} fullname];
               cnt = cnt+1;
           end
        end
    end

end

