program T3parser;
var
   Rel : string;
   Pos, ErrPos :integer;
   Ch, EOT : char;

procedure NextCh();
begin
   Pos := Pos + 1;
   while (Pos < length(Rel)) and (Rel[Pos] = ' ') do
      Pos := Pos + 1;
   if Pos <= length(Rel) then
      Ch := Rel[Pos]
   else
      Ch := EOT;
end;

procedure Error(S : string; EPos : integer);
var
   i : integer;
begin
   if ErrPos = 0 then begin
      ErrPos := EPos;
      for i := 1 to ErrPos-1 do 
         Write(' ');
      Writeln('^');
      Writeln(S);
      Pos := length(Rel);
   end;
end;

procedure Name();//Имя
begin
   if Ch in ['a'..'z', 'A'..'Z'] then
      NextCh()
   else
      Error('Ожидается буква', Pos);
   while Ch in ['a'..'z', 'A'..'Z', '0'..'9'] do 
      NextCh();
end;

procedure Number();//Число
begin
   if Ch in ['0'..'9'] then
      NextCh()
   else
      Error('Ожидается цифра', Pos);
   while Ch in ['0'..'9'] do
      NextCh();
end;

procedure Operand();//Операнд
begin
   if Ch in ['a'..'z', 'A'..'Z'] then
      Name()
   else if Ch in ['0'..'9'] then 
      Number()
   else
      Error('Ожидается операнд', Pos);
end;

procedure Sign();//Знак
begin
   if Ch = '>' then begin
      NextCh();
      if Ch = '=' then
         NextCh();
      end
   else if Ch = '<' then begin
      NextCh();
      if Ch in ['>', '='] then
         NextCh();
      end
   else if Ch = '=' then
      NextCh()
   else
      Error('Ожидается знак сравнения', Pos);
end;

procedure Relation();
begin
   Operand();
   Sign();
   Operand();
end;

procedure ResetText();
begin
   Pos := 0;
   NextCh();
   ErrPos := 0;
end;

begin
   repeat
      Readln(Rel);
      ResetText();
      Relation();
      if (Ch = EOT) and (ErrPos = 0) then
         Writeln('Правильно')
      else
         Error('Ожидается конец текста', Pos);
   until false;
end.