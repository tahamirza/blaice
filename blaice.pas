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
   peek      : char;

procedure getChar();
begin
   get(input);
   ch   := peek;
   peek := input^;
end;

procedure getToken();
type tstate = (start, readingid, skip, finished, failed);
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
      case state of
	start:
	      begin
		 case ch of
		   { identifier }
		   'a'..'z','A'..'Z':
		 begin
		    state := readingid;
		    done := false;
		    nextToken.name := identifier;
		    nextToken.text[i] := ch;
		    i := i + 1;
		 end;

		   '(':
		 begin
		    nextToken.name := parenleft;
		    nextToken.text[0] := ch;
		    state := finished;
		 end;

		   ')':
		 begin
		    nextToken.name := parenright;
		    nextToken.text[0] := ch;
		    state := finished;
		 end;

		   ' ','!',chr(10),chr(13): state := skip;

		   ';':
		 begin
		    nextToken.name := semicolon;
		    nextToken.text[0] := ch;
		    state := finished;
		 end;

		   { todo: reading whole string }
		   '''':
		 begin
		    nextToken.name := characterstring;
		    nextToken.text[0] := ch;
		    state := finished;
		 end;

		   ',':
		 begin
		    nextToken.name := comma;
		    nextToken.text[0] := ch;
		    state := finished;
		 end;

		   '.':
		 begin
		    nextToken.name := period;
		    nextToken.text[0] := ch;
		    state := finished;
		 end;

		 end; {case ch}
	      end;    {start:}

	failed: done := true;
	
	finished: begin
		     getchar;
		     done := true;
		  end;
	skip:
	     begin
		getchar;
		state := start;
	     end;

	readingid:
		  begin
		     state := failed;
		     getchar;
		     case ch of
		       'A'..'Z','a'..'z','0'..'9':
		     begin
			nextToken.name := identifier;
			nextToken.text[i] := ch;
			i := i + 1;
			state := readingid;
		     end;

		     end;
		  end;
      end;
   end;		      {while}
end;

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
