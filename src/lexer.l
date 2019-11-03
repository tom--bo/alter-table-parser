%{
#include <string.h>
#include "yystype.h"
#include "parser.tab.h"
%}
%%
0|[1-9][0-9]*    { yylval = strdup(yytext); return IntNum; }
([0-9]+"."[0-9]*)|([0-9]*"."[0-9]+) { yylval = strdup(yytext); return RealNum; }

","              { return Comma; }
";"              { return Semi; }
"("              { return LPar; }
")"              { return RPar; }
"]"              { return BrckRPar; }
"["              { return BrckLPar; }
"="              { yylval = yytext; return Equal; }
"action"         { yylval = yytext; return Action; }
"add"            { yylval = yytext; return Add; }
"after"          { yylval = yytext; return After; }
"algorithm"      { yylval = yytext; return Algorithm; }
"alter"          { yylval = yytext; return Alter; }
"as"             { yylval = yytext; return As; }
"asc"            { yylval = yytext; return Asc; }
"auto_increment" { yylval = yytext; return AutoIncrement; }
"bigint"         { yylval = yytext; return BigInt; }
"binary"         { yylval = yytext; return Binary; }
"bit"            { yylval = yytext; return Bit; }
"blob"           { yylval = yytext; return Blob; }
"bool"           { yylval = yytext; return Bool; }
"boolean"        { yylval = yytext; return Boolean; }
"btree"          { yylval = yytext; return Btree; }
"cascade"        { yylval = yytext; return Cascade; }
"change"         { yylval = yytext; return Change; }
"char"           { yylval = yytext; return Char; }
"charset"        { yylval = yytext; return Charset; }
"character"      { yylval = yytext; return Character; }
"checksum"       { yylval = yytext; return Checksum; }
"collate"        { yylval = yytext; return Collate; }
"column"         { yylval = yytext; return Column; }
"column_format"  { yylval = yytext; return ColumnFormat; }
"comment"        { yylval = yytext; return Comment; }
"compact"        { yylval = yytext; return Compact; }
"compressed"     { yylval = yytext; return Compressed; }
"compression"    { yylval = yytext; return Compression; }
"constraint"     { yylval = yytext; return Constraint; }
"convert"        { yylval = yytext; return Convert; }
"copy"           { yylval = yytext; return Copy; }
"create"         { yylval = yytext; return Create; }
"date"           { yylval = yytext; return Date; }
"datetime"       { yylval = yytext; return Datetime; }
"dec"            { yylval = yytext; return Dec; }
"decimal"        { yylval = yytext; return Decimal; }
"default"        { yylval = yytext; return Default; }
"delete"         { yylval = yytext; return Delete; }
"desc"           { yylval = yytext; return Desc; }
"disk"           { yylval = yytext; return Disk; }
"disable"        { yylval = yytext; return Disable; }
"discard"        { yylval = yytext; return Discard; }
"double"         { yylval = yytext; return Double; }
"drop"           { yylval = yytext; return Drop; }
"dynamic"        { yylval = yytext; return Dynamic; }
"enable"         { yylval = yytext; return Enable; }
"encryption"     { yylval = yytext; return Encryption; }
"engine"         { yylval = yytext; return Engine; }
"enum"           { yylval = yytext; return Enum; }
"exists"         { yylval = yytext; return Exists; }
"exclusive"      { yylval = yytext; return Exclusive; }
"first"          { yylval = yytext; return First; }
"fixed"          { yylval = yytext; return Fixed; }
"float"          { yylval = yytext; return Float; }
"force"          { yylval = yytext; return Force; }
"foreign"        { yylval = yytext; return Foreign; }
"full"           { yylval = yytext; return Full; }
"fulltext"       { yylval = yytext; return Fulltext; }
"generated"      { yylval = yytext; return Generated; }
"hash"           { yylval = yytext; return Hash; }
"if"             { yylval = yytext; return IF; }
"import"         { yylval = yytext; return Import; }
"index"          { yylval = yytext; return Index; }
"inplace"        { yylval = yytext; return Inplace; }
"int"            { yylval = yytext; return Int; }
"integer"        { yylval = yytext; return Integer; }
"key"            { yylval = yytext; return Key; }
"keys"           { yylval = yytext; return Keys; }
"lock"           { yylval = yytext; return Lock; }
"longblob"       { yylval = yytext; return LongBlob; }
"longtext"       { yylval = yytext; return LongText; }
"lz4"            { yylval = yytext; return Lz4; }
"match"          { yylval = yytext; return Match; }
"mediumblob"     { yylval = yytext; return MediumBlob; }
"mediumint"      { yylval = yytext; return MediumInt; }
"mediumtext"     { yylval = yytext; return MediumText; }
"memory"         { yylval = yytext; return Memory; }
"modify"         { yylval = yytext; return Modify; }
"national"       { yylval = yytext; return National; }
"no"             { yylval = yytext; return No; }
"none"           { yylval = yytext; return None; }
"not"            { yylval = yytext; return Not; }
"numeric"        { yylval = yytext; return Numeric; }
"on"             { yylval = yytext; return On; }
"partial"        { yylval = yytext; return Partial; }
"precision"      { yylval = yytext; return Precision; }
"primary"        { yylval = yytext; return Primary; }
"real"           { yylval = yytext; return Real; }
"redundant"      { yylval = yytext; return Redundant; }
"references"     { yylval = yytext; return References; }
"rename"         { yylval = yytext; return Rename; }
"restrict"       { yylval = yytext; return Restrict; }
"row_format"     { yylval = yytext; return RowFormat; }
"set"            { yylval = yytext; return Set; }
"shared"         { yylval = yytext; return Shared; }
"simple"         { yylval = yytext; return Simple; }
"smallint"       { yylval = yytext; return SmallInt; }
"spatial"        { yylval = yytext; return Spatial; }
"storage"        { yylval = yytext; return Storage; }
"stored"         { yylval = yytext; return Stored; }
"symbol"         { yylval = yytext; return Symbol; }
"table"          { yylval = yytext; return Table; }
"tablespace"     { yylval = yytext; return Tablespace; }
"temporary"      { yylval = yytext; return Temporary; }
"text"           { yylval = yytext; return Text; }
"time"           { yylval = yytext; return Time; }
"timestamp"      { yylval = yytext; return Timestamp; }
"tinyblob"       { yylval = yytext; return TinyBlob; }
"tinyint"        { yylval = yytext; return TinyInt; }
"tinytext"       { yylval = yytext; return TinyText; }
"to"             { yylval = yytext; return To; }
"unique"         { yylval = yytext; return Unique; }
"unsigned"       { yylval = yytext; return Unsigned; }
"update"         { yylval = yytext; return Update; }
"using"          { yylval = yytext; return Using; }
"utf8"           { yylval = yytext; return Utf8;}
"utf8mb4"        { yylval = yytext; return Utf8mb4;}
"validation"     { yylval = yytext; return Validation; }
"varbinary"      { yylval = yytext; return Varbinary; }
"varchar"        { yylval = yytext; return Varchar; }
"virtual"        { yylval = yytext; return Virtual; }
"with"           { yylval = yytext; return With; }
"without"        { yylval = yytext; return Without; }
"year"           { yylval = yytext; return Year; }
"zerofill"       { yylval = yytext; return Zerofill; }
"zlib"           { yylval = yytext; return Zlib; }
"null"           { yylval = yytext; return Snull; }

['`]?[a-z0-9_\-]*['`]? { yylval = strdup(yytext); return SQAnyStr; }
"/*"[a-z0-9 ]*"*/"   {}
"\n"|" "|"\t"        {}

%%
                  
int yywrap(void) {
	return 1; 
}
