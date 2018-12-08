begin
   ch := input^;
   get(input);
   peek := input^;
   while not eof do
   begin
      getToken;
      writeln(nextToken.text);
   end;
end .
