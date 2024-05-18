program PonteirosExemplo;

type
  PInteger = ^Integer; // Define um tipo de ponteiro para um inteiro

var
  x: Integer;
  px: PInteger; // Declaração de um ponteiro para um inteiro

begin
  // Atribui um valor a x
  x := 10;

  // Atribui o endereço de x ao ponteiro px
  px := @x;

  // Exibe o valor de x
  WriteLn('Valor de x:', x);

  // Exibe o valor apontado por px (deve ser o mesmo que x)
  WriteLn('Valor apontado por px:', px^);

  // Modifica o valor apontado por px (o valor de x também será modificado)
  px^ := 20;

  // Exibe o novo valor de x
  WriteLn('Novo valor de x:', x);

  // Libera a memória alocada para o ponteiro
  Dispose(px);
end.