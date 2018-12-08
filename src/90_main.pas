begin
   initLexer();
   while not eof do
   begin
      getToken();
      writeln(nextToken.text);
   end;
end .
