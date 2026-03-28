lado(A, B, Lista) :-
    nextto(A, B, Lista);
    nextto(B, A, Lista).

esquerda(A, B, Lista) :-
    nth1(I, Lista, A),
    nth1(J, Lista, B),
    I < J.

solucao(S) :-

        S = [
        pessoa(_,_,_,_,_,_),
        pessoa(_,_,_,_,_,_),
        pessoa(_,_,_,_,_,_),
        pessoa(_,_,_,_,_,_),
        pessoa(_,_,_,_,_,_)
        ],

    Nomes = ['Denis', 'Joao', 'Lenin', 'Otavio', 'Will'],
    Mochilas = ['Amarela','Azul','Branca','Verde','Vermelha'],
    Meses = ['Agosto','Setembro','Dezembro','Maio','Janeiro'],
    Jogos = ['3 ou mais','Caca Palavras','Cubo Vermelho','Jogo da Forca','Prob. de Logica'],
    Materias = ['Historia','Biologia','Geografia','Matematica','Portugues'],
    Sucos = ['Laranja','Limao','Maracuja','Morango','Uva'],

    % Regras
    % Joao gosta de historia
    member(pessoa('Joao', _, _, _, 'Historia', _), S),

    % Quem gosta de suco de Uva gosta de logica
    member(pessoa(_,_,_, 'Prob. de Logica',_, 'Uva'), S),

    % Na primeira posicao esta quem gosta de suco de Limao
    nth1(1, S, pessoa(_,_,_,_,_, 'Limao')),

    % Na terceira posicao esta quem gosta de suco de Morango
    nth1(3, S, pessoa(_,_,_,_,_, 'Morango')),

    % Lenin está na quinta posicao
    nth1(5, S, pessoa('Lenin',_,_,_,_,_)),

    % Quem gosta de jogo da forca esta na posicao 3
    nth1(3, S, pessoa(_,_,_, 'Jogo da Forca',_,_)),

    % Quem nasceu em Setembro está ao lado de quem gosta de suco de Laranja
    lado(
    pessoa(_,_, 'Setembro',_,_,_),
    pessoa(_,_,_,_,_, 'Laranja'),
    S
    ),

    % Will esta ao lado de quem gosta de probabildade de Logica
    lado(
    pessoa('Will',_,_,_,_,_),
    pessoa(_,_,_, 'Prob. de Logica',_,_),
    S
    ),

    % Jogo da forca esta ao lado de quem tem mochila Vermelha
    lado(
    pessoa(_,_,_, 'Jogo da Forca',_,_),
    pessoa(_, 'Vermelha',_,_,_,_),
    S
    ),

    % Quem gosta de logica esta ao lado de quem tem mochila Amarela
    lado(
    pessoa(_,_,_, 'Prob. de Logica',_,_),
    pessoa(_, 'Amarela',_,_,_,_),
    S
    ),

    % Quem nasceu em janeiro esta ao lado de quem nasceu em Setembro
    lado(
    pessoa(_,_, 'Janeiro',_,_,_),
    pessoa(_,_, 'Setembro',_,_,_),
    S
    ),

    % Jogo da forca esta ao lado de 3 ou mais
    lado(
    pessoa(_,_,_, 'Jogo da Forca',_,_),
    pessoa(_,_,_, '3 ou mais',_,_),
    S
    ),

    % Quem tem mochila Azul esta a esquerda de quem nasceu em Maio
    esquerda(
    pessoa(_, 'Azul',_,_,_,_),
    pessoa(_,_, 'Maio',_,_,_),
    S
    ),

    % Quem gosta de suco de Uva esta a direita de quem tem mochila Azul
    esquerda(
    pessoa(_, 'Azul',_,_,_,_),
    pessoa(_,_,_,_,_, 'Uva'),
    S
    ),

    % Quem tem mochila branca esta exatamente a esquerda do Will
    nextto(
    pessoa(_, 'Branca',_,_,_,_),
    pessoa('Will',_,_,_,_,_),
    S
    ),

    % Quem gosta de suco de Uva esta exatamente a esquerda de quem gosta de Portugues
    nextto(
    pessoa(_,_,_,_,_, 'Uva'),
    pessoa(_,_,_,_, 'Portugues',_),
    S
    ),

    % Quem gosta de Biologia gosta de suco de Morango
    member(pessoa(_,_,_,_, 'Biologia', 'Morango'), S),

    % Quem gosta de Matematica nasceu em Dezembro
    member(pessoa(_,_, 'Dezembro',_, 'Matematica',_), S),

    %Quem gosta de Matematica tambem gosta de suco de Maracuja
    member(pessoa(_,_,_,_, 'Matematica', 'Maracuja'), S),

    % Quem tem mochila azul nasceu em Janeiro
    member(pessoa(_, 'Azul', 'Janeiro',_,_,_), S),

    % Otavio esta em uma das pontas
    (
    nth1(1, S, pessoa('Otavio',_,_,_,_,_));
    nth1(5, S, pessoa('Otavio',_,_,_,_,_))
    ),

    % Quem gosta de Cubo vermelho esta em uma das pontas
    (
    nth1(1, S, pessoa(_,_,_, 'Cubo Vermelho',_,_));
    nth1(5, S, pessoa(_,_,_, 'Cubo Vermelho',_,_))
    ),

    %Quem nasceu em Setembro esta ao lado de quem gosta de Cubo vermelho
    lado(
    pessoa(_,_, 'Setembro',_,_,_),
    pessoa(_,_,_, 'Cubo Vermelho',_,_),
    S
    ),

    % permotacoes para nao repetir nomes
    maplist(arg(1), S, ListaNomes),
    permutation(Nomes, ListaNomes),

    maplist(arg(2), S, ListaMochilas),
    permutation(Mochilas, ListaMochilas),

    maplist(arg(3), S, ListaMeses),
    permutation(Meses, ListaMeses),

    maplist(arg(4), S, ListaJogos),
    permutation(Jogos, ListaJogos),

    maplist(arg(5), S, ListaMaterias),
    permutation(Materias, ListaMaterias),

    maplist(arg(6), S, ListaSucos),
    permutation(Sucos, ListaSucos).

imprimir(S) :-
    write('-------------------------------------------------------------'), nl,
    write('| Pos | Nome | Mochila | Mes | Jogo | Materia | Suco |'), nl,
    write('-------------------------------------------------------------'), nl,
    imprimir_linhas(S, 1),
    write('-------------------------------------------------------------'), nl.

imprimir_linhas([], _).
imprimir_linhas([pessoa(N,Moch,Mes,Jogo,Mat,Suco)|T], Pos) :-
    format('| ~w   | ~w | ~w | ~w | ~w | ~w | ~w |~n',
           [Pos, N, Moch, Mes, Jogo, Mat, Suco]),
    Pos1 is Pos + 1,
    imprimir_linhas(T, Pos1).

main :-
    statistics(cputime, T1),

    solucao(S),
    imprimir(S),

    statistics(cputime, T2),

    Tempo is T2 - T1,
    format('~nO tempo de execucao foi ~6f segundos~n', [Tempo]).