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
