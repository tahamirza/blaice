procedure readToken(expected : tokentype);
begin
   getToken();

   if (nextToken.name <> expected) then
      {todo: convert 'identifiers' into proper keywords}
      if (nextToken.name <> identifier) then
	 writeln('Unexpected token ', nextToken.text);

   writeln(nextToken.text);
end;

procedure identifierList();
begin
   {todo: read more than one id}
   readToken(identifier);
end;

procedure programHeading();
begin
   readToken(symprogram);
   readToken(identifier);
   {todo: peek and see if there is not an identifier list}
   readToken(parenleft);
   identifierList();
   readToken(parenright);
end;

procedure procedureStatement();
begin
   {todo: handle more than just writeln}
   readToken(identifier);
   readToken(parenleft);
   {identifierList();}
   readToken(characterstring);
   readToken(parenright);
end;

procedure statement();
begin
   {todo: expand to more than just procedure statement}
   procedureStatement();
end;

procedure statementSequence();
begin
   statement();
   {todo: read semicolon and then more statements}
end;

procedure compoundStatement();
begin
   readToken(symbegin);
   statementSequence();
   readToken(symend);
end;

procedure block();
begin
   {todo: label, const, type, variable, procedure declarations}
   compoundStatement();
end;

procedure programStart();
begin
   programHeading();
   readToken(semicolon);
   block();
   readToken(period);
end;
