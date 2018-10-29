{A Pascal compiler written in Pascal :)}
program blaice;

type
   string    = array[0..255] of char;
   tokentype =  (
                 identifier,
                 number,
                 directive,
                 digitsequence,
                 characterstring,
                 plus,
                 minus,
                 times,
                 slash,
                 equals,
                 lessthan,
                 greaterthan,
                 squarebracketleft,
                 squarebracketright,
                 period,
                 comma,
                 colon,
                 semicolon,
                 caret,
                 parenleft,
                 parenright,
                 notequal,
                 lessthanorequal,
                 greaterthanorequal,
                 assignment,
                 range,
                 symand,
                 symarray,
                 symbegin,
                 symcase,
                 symconst,
                 symdiv,
                 symdo,
                 symdownto,
                 symelse,
                 symend,
                 symfile,
                 symfor,
                 symfunction,
                 symgoto,
                 symif,
                 symin,
                 symlabel,
                 symmod,
                 symnil,
                 symnot,
                 symof,
                 symor,
                 sympacked,
                 symprocedure,
                 symprogram,
                 symrecord,
                 symrepeat,
                 symset,
                 symthen,
                 symto,
                 symtype,
                 symuntil,
                 symvar,
                 symwhile,
                 symwith
                 );
   token     = record
                  line, column : integer;
                  name         : tokentype;
                  text         : string;
               end;

var
   nextToken : token;
   ch        : char;

procedure getChar();
begin
   ch := input^;
   get(input);
end;

procedure getToken();
type tstate = (start, readingid);
var
   done  : boolean;
   i     : integer;
   state : tstate;

begin
   done := false;
   i := 0;
   nextToken.text := '';
   state := start;
   while not done do
   begin
      done := true;
      case state of
        start:
              begin
                 getChar;
                 case ch of
                   { identifier }
                   'a'..'z':
                   begin
                      state := readingid;
                      done := false;
                   end;
                   'A'..'Z':
                   begin
                      state := readingid;
                      done := false;
                   end;
                 end;
              end;
        readingid:
                  begin
                     case ch of

                       'A'..'Z':
                     begin
                        nextToken.name := identifier;
                        nextToken.text[i] := ch;
                        i := i + 1;
                        getChar;
                        done := false;
                     end;

                       'a'..'z':
                     begin
                        nextToken.name := identifier;
                        nextToken.text[i] := ch;
                        i := i + 1;
                        getChar;
                        done := false;
                     end;

                       '0'..'9':
                     begin
                        nextToken.name := identifier;
                        nextToken.text[i] := ch;
                        i := i + 1;
                        getChar;
                        done := false;
                     end;

                     end;
                  end;
      end;
   end;
end;

begin
   while not eof do
   begin
      getToken;
      writeln(nextToken.text);
   end;
end .
