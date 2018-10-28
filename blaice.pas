{A Pascal compiler written in Pascal :)}
program blaice;

type
   string    = array[0..255] of char;
   tokentype =  (identifier, number);
   token     = record
                  line, column : integer;
                  name         : tokentype;
                  text         : string;
               end;

var nextToken : token;

procedure getToken();
var
   ch   : char;
   done : boolean;
   i    : integer;
begin
   done := false;
   i := 0;
   nextToken.text := '';
   while not done do
   begin
      ch := input^;
      get(input);
      
      case ch of
        'a'..'z':
        begin
           nextToken.name := identifier;
           nextToken.text[i] := ch;
        end;
        {whitespace}
        ' ',chr(13),chr(10): done := true;
      end;

      i := i + 1;
   end;
end;

begin
   while not eof do
      begin
         getToken;
         writeln(nextToken.text);
      end;
end .
