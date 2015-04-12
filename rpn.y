%{

#include <stdio.h>
#include <ctype.h>
#include <math.h>

#define YYSTYPE double

int yylex(void);
void yyerror(const char* s);

%}

%token NUM
%token SPECIAL

%%

input   : /* empty */
        | input line
;

line    : '\n'
        | expr '\n'
                { printf("\t%.10g\n", $1); }
;

expr    : NUM
        | SPECIAL
                {   /** SPECIAL終端文字に対しては100を使用した上でメッセージを出力 */
                    $$ = 100;
                    printf("thank to use this exapmle!!\n");
                }
        | expr expr '+'
                { $$ = $1 + $2;            }
        | expr expr '-'
                { $$ = $1 - $2;            }
        | expr expr '*'
                { $$ = $1 * $2;            }
        | expr expr '/'
                { $$ = $1 / $2;            }
        | expr expr '^'
                { $$ = pow($1, $2);        }
        | expr 'n'
                { $$ = -$1;                }
        | expr 'd'
                { $$ = pow($1, 2);         }
;

%%

/* トークン解析関数 */
int yylex(void)
{
  int c;

  /* 空白、タブは飛ばす */
  while((c = getchar()) == ' ' || c == '\t')
    ;
  /* 数値を切り出す */
  if(c == '.' || isdigit(c))
  {
    ungetc(c, stdin);
    scanf("%lf", &yylval);
    return NUM;
  }
  /* EOF を返す */
  if(c == EOF)
    return 0;
  /* Xは特殊文字として定義 */
  if (c == 'X')
    return SPECIAL;
  /* 文字を返す */
  return c;
}

/* エラー表示関数 */
void yyerror(const char* s)
{
  fprintf(stderr, "error: %s\n", s);
}

int main(void)
{
  /* 構文解析関数 yyparse */
  return yyparse();
}
