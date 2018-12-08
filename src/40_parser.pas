procedure readToken();
begin
   getToken();
   writeln(nextToken.text);
end;

procedure identifierList();
begin
   {todo: read more than one id}
   readToken(); {identifer}
end;

procedure programHeading();
begin
   readToken(); {program}
   readToken(); {identifier}
   {todo: peek and see if there is not an identifier list}
   readToken(); {left paren}
   identifierList();
   readToken(); {right paren}
end;

procedure procedureStatement();
begin
   {todo: handle more than just writeln}
   readToken(); {identifier}
   readToken(); {left paren}
   identifierList();
   readToken(); {right paren}
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
   readToken(); {begin}
   statementSequence();
   readToken(); {end}
end;

procedure block();
begin
   {todo: label, const, type, variable, procedure declarations}
   compoundStatement();
end;

procedure programStart();
begin
   programHeading();
   readToken(); {semicolon}
   block();
   readToken(); {fullstop}
end;
