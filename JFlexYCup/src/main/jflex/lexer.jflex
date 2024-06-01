package umg.compiladores;

import java_cup.runtime.*;

%%

%class Lexer
%unicode
%public
%cup
%ignorecase
%char
%line

%{
  void printToken(String tokenName) {
    System.out.println(tokenName);
  }

  private Symbol symbol(int tipo, Object valor) {
    return new Symbol(tipo, yyline, yycolumn, valor);
  }
%}

D =  [0-9]
L = [A-Za-z]
SIM = [!-$]|[&-)]|\/|-|[<->]|@|[\[-\`]
COMLNS = \<\!([^"!>"]|[\r|\f|\s|\t|\n])*\!\>
COMLN = \/\/.*
TXT = \"(\!|[\#-\»]|\s)*\"
ASIG = -(\s)*>
ID = {L}({L}|{L}|{D}|_)+
SALT  =  \\n|\\\"|\\\'
ESPACIOS = [\r|\f|\s|\t|\n]
VALOR_ENT = [0-9]+
VALOR_FLOT = [0-9]+(\.[0-9]+)?

%%

<YYINITIAL> {
    "\""        {printToken("comilla");}
    "entero"                { printToken("entero"); return symbol(sym.ENTERO, yytext()); }
    "flotante"              { printToken("flotante"); return symbol(sym.FLOTANTE, yytext()); }
    "+"                     { printToken("suma"); return symbol(sym.SUMA, yytext()); }
    "-"                     { printToken("resta"); return symbol(sym.RESTA, yytext()); }
    "*"                     { printToken("multiplicacion"); return symbol(sym.MULTIPLICACION, yytext()); }
    "&&"                    { printToken("and"); return symbol(sym.AND, yytext()); }
    "||"                    { printToken("or"); return symbol(sym.OR, yytext()); }
    "!"                     { printToken("not"); return symbol(sym.NOT, yytext()); }
    "si"                    { printToken("si"); return symbol(sym.SI, yytext()); }
    "sino"                  { printToken("sino"); return symbol(sym.SINO, yytext()); }
    "entonces"              { printToken("entonces"); return symbol(sym.ENTONCES, yytext()); }
    "fin_si"                { printToken("fin_si"); return symbol(sym.FIN_SI, yytext()); }
    ";"                     { printToken(";"); return symbol(sym.PUNTO_Y_COMA, yytext()); }
    ","                     {printToken(","); return symbol(sym.COMA, yytext());}
    "imprimir"              { printToken("imprimir"); return symbol(sym.IMPRIMIR, yytext()); }
    "("                     { printToken("("); return symbol(sym.PARENTESIS_ABRE, yytext()); }
    ")"                     { printToken(")"); return symbol(sym.PARENTESIS_CIERRA, yytext()); }
    "mientras"              { printToken("mientras"); return symbol(sym.MIENTRAS, yytext()); }
    "fin_mientras"          { printToken("fin_mientras"); return symbol(sym.FIN_MIENTRAS, yytext()); }
    "hacer"                 { printToken("hacer"); return symbol(sym.HACER, yytext()); }
    "=="                    {printToken("=="); return symbol(sym.IGUALIGUAL, yytext());}
    "<="                    {printToken("<="); return symbol(sym.MENOR_IGUAL, yytext());}
    ">="                    {printToken(">="); return symbol(sym.MAYOR_IGUAL, yytext());}
    "="                     { printToken("="); return symbol(sym.IGUAL, yytext()); }
    "<"                     { printToken("<"); return symbol(sym.MENOR_QUE, yytext()); }
    ">"                     {printToken(">"); return symbol(sym.MAYOR_QUE,yytext());}
    "funcion"               { printToken("funcion"); return symbol(sym.FUNCION, yytext()); }
    "retorna"               { printToken("retorna"); return symbol(sym.RETORNA, yytext()); }
    "fin_funcion"           { printToken("fin_funcion"); return symbol(sym.FIN_FUNCION, yytext()); }
    "procedimiento"         { printToken("procedimiento"); return symbol(sym.PROCEDIMIENTO, yytext()); }
    "fin_procedimiento"     { printToken("fin_procedimiento"); return symbol(sym.FIN_PROCEDIMIENTO, yytext()); }
    "leer"                  { printToken("leer"); return symbol(sym.LEER, yytext()); }
    {ESPACIOS}   { }
    "/"                     { printToken("division"); return symbol(sym.DIVISION, yytext()); }
    {COMLN}                 { printToken("comentario una linea"); return symbol(sym.COMENTARIO_LINEA, yytext()); }
    {COMLNS}                { printToken("comentario multilinea"); return symbol(sym.COMENTARIO_MULTILINEA, yytext()); }
    {TXT}                   { printToken("cadena"); return symbol(sym.CADENA, yytext()); }
    {ID}                    { printToken("nombre variable"); return symbol(sym.NOMBRE_VARIABLE, yytext()); }
    {VALOR_ENT}             { printToken("valor de un entero"); return symbol(sym.VALOR_ENTERO, yytext());}
    {VALOR_FLOT}            { printToken("valor de un flotante"); return symbol(sym.VALOR_FLOTANTE, yytext()); }
    .                       { throw new Error("Caracter no reconocido: " + yytext()); }


}