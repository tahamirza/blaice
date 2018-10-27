{A Pascal compiler written in Pascal :)}
program blaice;
var ch : char;
begin
   while not eof do
      begin
         ch := input^;
         get(input);
         write(ch);
      end
end .
