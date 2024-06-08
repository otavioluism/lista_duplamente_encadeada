program ListaDuplamenteEncadeada;

uses
  crt; // Importa a unidade crt para acesso às funções de controle de terminal

type
  PNode = ^Node; // Define um tipo de ponteiro para um record Node
  Node = record
    priority: Boolean;
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
  choice: Integer;
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

function CreateNode(value: Integer; priority: Boolean): PNode; // Criando uma funcao que retorna um ponteiro do tipo PNode
var
  newNode: PNode;
begin
  New(newNode); // funcao para alocar memoria
  newNode^.prev := nil; // Acessando o valor prev e adicionando valor nulo
  newNode^.next := nil;
  newNode^.data := value;
  newNode^.priority := priority;
  CreateNode := newNode;
end;

function IsEmptyList(list: PList): Boolean; // Corrigindo a declaração do tipo Booleano
begin
  if list^.size = 0 then // Usando "=" para comparar igualdade
    IsEmptyList := True
  else
    IsEmptyList := False;
end;

procedure AddInBeginList(list: PList; value: Integer; priority: Boolean);
var
  newNode: PNode;
begin
  newNode := CreateNode(value, priority);
  if IsEmptyList(list) then // Se a lista estiver vazia
  begin
    list^.init := newNode; // O início da lista apontando para o primeiro nó
    list^.last := newNode; // O final da lista apontando para o primeiro nó
    list^.size := list^.size + 1; // Incrementando o tamanho da lista
  end
  else
  begin
    newNode^.next := list^.init; // Novo o proximo apontara para o que o inicio da lista esta apontando (poderia adicionar fora da condicional)
    list^.init^.prev := newNode; // O no que estava sendo apontado pelo inicio da lista anterior passa a a apontar ao novo nó criado no inicio
    list^.init := newNode; // O início passa a apontar ao novo nó
    list^.size := list^.size + 1; // Incrementando o tamanho da lista
  end;
end;

procedure AddInEndList(list: PList; value: Integer; priority: Boolean);
var
  newNode: PNode;
begin
  newNode := CreateNode(value, priority);
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

procedure AddInListWithPriority(list: PList; value: Integer);
var
  newNode, auxNodePost, auxNode: PNode;
  flagNodeOnlyPririty: Boolean;
begin
  newNode := CreateNode(value, True);
  if IsEmptyList(list) then // Se a lista estiver vazia
  begin
    AddInBeginList(list, value, True);
  end
  else
  begin
    auxNode:= list^.last;
    while (auxNode^.priority = True) and (auxNode^.prev <> nil) do
    begin
      auxNode:= auxNode^.prev;
    end;
    if list^.init^.priority = True then 
    begin 
      AddInBeginList(list, value, True);
    end
    else
    begin 
      if list^.last^.priority = False then
      begin 
        newNode^.prev := auxNode;
        auxNode^.next := newNode;
        list^.last := newNode;
      end
      else
      begin 
        auxNodePost := auxNode^.next;
        newNode^.prev := auxNode;
        newNode^.next := auxNodePost;
        auxNodePost^.prev := newNode;
        auxNode^.next := newNode;
      end;
      list^.size := list^.size + 1;
    end;
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
      Write(node^.data, ' -> ');
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
      Write('[', node^.data, ']');
      node := node^.prev;
      cont := cont + 1; // Corrigindo o operador de atribuição
    end;
  end;
end;

procedure FreeList(var list: PList);
var
  current, temp: PNode;
begin
  current := list^.init;
  while current <> nil do
  begin
    temp := current;
    current := current^.next;
    Dispose(temp);
  end;
  Dispose(list);
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
    WriteLn('6 - Inserir um elemento na lista com prioridade');
    WriteLn('0 - Sair do programa'); // Adicionando uma opção para sair do programa
    Write('Digite sua escolha: ');
    ReadLn(choice);

    // Simulando um switch case
    case choice of
      1:
        begin
          clrscr;
          WriteLn('Inserindo um numero no inicio da lista:');
          WriteLn('Digite um numero:');
          ReadLn(item_value);
          AddInBeginList(list_global, item_value, False);
        end;
      2:
        begin
          clrscr;
          WriteLn('Inserindo um numero no final da lista:');
          WriteLn('Digite um numero:');
          ReadLn(item_value);
          AddInEndList(list_global, item_value, False);
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
      6:
        begin
          clrscr;
          WriteLn('Inserindo elemento com prioridade:');
          WriteLn('Digite um numero:');
          ReadLn(item_value);
          AddInListWithPriority(list_global, item_value);
        end;
      0:
        begin
          WriteLn('Saindo do programa...');
          FreeList(list_global); // Liberar memória ao sair do programa
        end;
    else
      WriteLn('Opção inválida.');
    end;
  until choice = 0; // Continuar o loop até que a escolha seja igual a 0 (sair do programa)
end.
