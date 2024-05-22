program ListaDuplamenteEncadeada;

uses
  crt; // Importa a unidade crt para acesso às funções de controle de terminal

type
  PNode = ^Node; // Define um tipo de ponteiro para um record Node
  Node = record
    data: Integer;
    prev: PNode;
    next: PNode;
  end;

  PList = ^List; // Define um tipo de ponteiro para um record List
  List = record 
    size: Integer; 
    init: PNode;
    last: PNode;
  end; 

var
  choice : Integer;
  item_value: Integer;
  list_global: PList;

function CreateList(): PList;
var
  newList: PList;
begin
  New(newList); // Alocando memoria para o ponteiro newList
  newList^.init := nil; // Acessando o valor begin e apontando para o incio da fila que é nula 
  newList^.last := nil; 
  newList^.size := 0;
  CreateList := newList;
end;

function CreateNode(value: Integer): PNode; // Criando uma funcao que retorna um ponteiro do tipo PNode
var
  newNode: PNode;
begin
  New(newNode); // funcao para alocar memoria 
  newNode^.prev := nil; // Acessando o valor prev e adicionando valor nulo
  newNode^.next := nil; 
  newNode^.data := value;
  CreateNode := newNode;
end;

function IsEmptyList(list: PList): Boolean; // Corrigindo a declaração do tipo Booleano
begin
  if list^.size = 0 then // Usando "=" para comparar igualdade
    IsEmptyList := True
  else 
    IsEmptyList := False;
end;

procedure AddInBeginList(list: PList; value: Integer);
var 
  newNode: PNode;
begin
  newNode := CreateNode(value);
  if IsEmptyList(list) then // Se a lista estiver vazia
  begin
    list^.init := newNode; // O início da lista apontando para o primeiro nó
    list^.last := newNode; // O final da lista apontando para o primeiro nó
    list^.size := list^.size + 1; // Incrementando o tamanho da lista
  end
  else
  begin
    newNode^.next := list^.init; // Novo o proximo apontara para o que o inicio da lista esta apontando (poderia adicionar fora da condiconal)
    list^.init^.prev := newNode; // O no que estava sendo apontando pelo incio da lista anterior passa a a apontar ao novo nó criado no inicio
    list^.init := newNode; // O início passa a apontar ao novo nó 
    list^.size := list^.size + 1; // Incrementando o tamanho da lista
  end;
end;

procedure AddInEndList(list: PList; value: Integer);
var 
  newNode: PNode;
begin
  newNode := CreateNode(value);
  if IsEmptyList(list) then // Se a lista estiver vazia
  begin
    list^.init := newNode; // O início da lista apontando para o primeiro nó
    list^.last := newNode; // O final da lista apontando para o primeiro nó
    list^.size := list^.size + 1; // Incrementando o tamanho da lista
  end
  else
  begin
    list^.last^.next := newNode;
    newNode^.prev := list^.last;
    list^.last := newNode;
    list^.size := list^.size + 1; // Incrementando o tamanho da lista
  end;
end;

procedure RemoveBeginList(list: PList);
var
  auxNode: PNode;
begin
  if not IsEmptyList(list) then // Se a lista não estiver vazia
  begin
    auxNode := list^.init;
    if list^.init = list^.last then // Se houver apenas um nó na lista
    begin
      list^.init := nil;
      list^.last := nil;
    end
    else // Se houver mais de um nó na lista
    begin
      list^.init := auxNode^.next;
      list^.init^.prev := nil;
    end;
    WriteLn('Elemento removido -> ', auxNode^.data);
    list^.size := list^.size - 1;
    WriteLn('Tamanho lista -> ', list^.size);
    Dispose(auxNode);
  end
  else // Se a lista estiver vazia
  begin
    WriteLn('Lista vazia, impossível remover elemento!');
  end;
end;



procedure PrintListBeginEnd(list: PList);
var 
  node: PNode;
  cont: Integer;
begin
  cont := 0; // Corrigindo o operador de atribuição
  node := list^.init; 

  if (list^.init = nil) and (list^.last = nil) then // Corrigindo as condições de comparação
  begin
    WriteLn('Lista vazia!');
  end
  else
  begin
    Write('L -> ');
    while node <> nil do // Corrigindo o operador de comparação
    begin 
      // WriteLn('Posicao -> ', cont, ' Valor = ', node^.data);
      // Write('[',node^.data,']');
      Write(node^.data,' -> ');
      node := node^.next;
      cont := cont + 1; // Corrigindo o operador de atribuição
    end;
    Write('NULL');
    WriteLn();
    WriteLn('Tamanho da lista: ', list^.size);
  end;
end;

procedure PrintListEndBegin(list: PList);
var 
  node: PNode;
  cont: Integer;
begin
  cont := 0; // Corrigindo o operador de atribuição
  node := list^.last; 

  if (list^.init = nil) and (list^.last = nil) then // Corrigindo as condições de comparação
  begin
    WriteLn('Lista vazia!');
  end
  else
  begin
    while node <> nil do // Corrigindo o operador de comparação
    begin 
      //WriteLn('Posicao -> ', cont, ' Valor = ', node^.data);
      Write('[',node^.data,']');
      node := node^.prev;
      cont := cont + 1; // Corrigindo o operador de atribuição
    end;
  end;
end;

begin
  list_global := CreateList(); // Criando a lista

  repeat // Trocando o loop while por repeat until
    WriteLn('Escolha uma opção:');
    WriteLn('1 - Inserir um elemento na lista no inicio da fila');
    WriteLn('2 - Inserir um elemento na lista no final da fila');
    WriteLn('3 - Imprimir a lista do primeiro ao ultimo elemento');
    WriteLn('4 - Imprimir a lista do ultimo ao primeiro elemento');
    WriteLn('5 - Removendo o elemento mais antigo da fila');
    WriteLn('0 - Sair do programa'); // Adicionando uma opção para sair do programa
    Write('Digite sua escolha: ');
    ReadLn(choice);

    // Simulando um switch case
    case choice of
      1:
        begin 
          clrscr;
          WriteLn('Inserindo um numero no inicio da lista:');
          WriteLn('Digite um numero:'); // Adicionando uma opção para sair do programa
          ReadLn(item_value);
          AddInBeginList(list_global, item_value);
        end;
      2:
        begin 
          clrscr;
          WriteLn('Inserindo um numero no final da lista:');
          WriteLn('Digite um numero:'); // Adicionando uma opção para sair do programa
          ReadLn(item_value);
          AddInEndList(list_global, item_value);
        end;
      3: 
        begin 
          clrscr;
          WriteLn('Imprimindo lista do primeiro ao ultimo elemento:');
          PrintListBeginEnd(list_global);
          WriteLn();
          WriteLn('------------------------------------');
        end;
      4: 
        begin 
          clrscr;
          WriteLn('Imprimindo lista do ultimo ao primeiro elemento:');
          PrintListEndBegin(list_global);
          WriteLn();
          WriteLn('------------------------------------');
        end;
      5: 
        begin 
          clrscr;
          WriteLn('Removendo o elemento mais antigo:');
          RemoveBeginList(list_global);
          WriteLn();
          WriteLn('------------------------------------');
        end;
      0: WriteLn('Saindo do programa...');
    else
      WriteLn('Opção inválida.');
    end;
  until choice = 0; // Continuar o loop até que a escolha seja igual a 0 (sair do programa)
end.