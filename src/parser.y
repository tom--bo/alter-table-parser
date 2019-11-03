%token IntNum RealNum Comma Semi LPar RPar BrckLPar BrckRPar Action Add After Algorithm Alter Always As Asc AutoIncrement AvgRowLength BigInt Binary Bit Blob Bool Boolean Btree Cascade Change Char Charset Character Checksum Collate Column ColumnFormat Comment Compact Compressed Compression Constraint Convert Copy Create Date Datetime Dec Decimal Default Delete Desc Disable Discard Disk Double Drop Dynamic Enable Encryption Engine Enum Exclusive Exists First Fixed Float Force Foreign Full Fulltext Generated Hash IF Import Index Inplace Int Integer Key Keys Lock LongBlob LongText Lz4 Match MediumBlob MediumInt MediumText Memory Modify National No None Not Snull Numeric On Partial Precision Primary Real Redundant References Rename Restrict RowFormat Set Shared SmallInt Simple Spatial Storage Stored Symbol Table Tablespace Temporary Text Time Timestamp TinyBlob TinyInt TinyText To Unique Unsigned Update Using Utf8 Utf8mb4 Validation Varbinary Varchar Virtual With Without Year SQAnyStr AnyStr Zerofill Zlib Error Equal
%{
#include <stdio.h>
#include "yystype.h"
#include "calc.h"

// #define YYDEBUG 1

void yyerror(char* s) {
    printf("[Error] %s or alter-table-parser doesn't support yet...\n", s);
}
%}
%%

Expression: AlterTable {}
AlterTable: Alter Table SQAnyStr AlterSpecifications OptSemi

AlterSpecifications: AlterSpecification
				   | AlterSpecifications Comma AlterSpecification

AlterSpecification: Add OptColumn SQAnyStr ColDef OptPosition                                     { printf("type = 1\n"); }
                  | Add IndexKey SQAnyStr OptIndexType LPar KeyParts RPar                         { printf("type = 2\n"); }
                  | Add FulltextSpatial OptIndexKey OptIndexName OptIndexType KeyParts            { printf("type = 3\n"); }
                  | Add OptConstraintSymbol Primary Key OptIndexType KeyParts                     { printf("type = 4\n"); }
                  | Add OptConstraintSymbol Unique IndexKey SQAnyStr OptIndexType KeyParts        { printf("type = 5\n"); }
                  | Add OptConstraintSymbol Foreign Key OptIndexName SQAnyStr ReferenceDefinition { printf("type = 6\n"); }
                  | Algorithm OptEqual AlgorithmType                                              { printf("type = 7\n"); }
                  | Alter OptColumn SQAnyStr SQAnyStr ColDef OptPosition                          { printf("type = 8\n"); }
                  | Change OptColumn SQAnyStr SQAnyStr ColDef OptPosition                         { printf("type = 9\n"); }
                  | OptDefault CharsetDef OptCollateDef                                           { printf("type = 10\n"); }
                  | Convert To CharsetDef OptCollateDef                                           { printf("type = 11\n"); }
                  | DisableEnable Keys                                                            { printf("type = 12\n"); }
                  | DiscardImport Tablespace                                                      { printf("type = 13\n"); }
                  | Drop OptColumn SQAnyStr                                                       { printf("type = 14\n"); }
                  | Drop IndexKey SQAnyStr                                                        { printf("type = 15\n"); }
                  | Drop Primary Key                                                              { printf("type = 16\n"); }
                  | Drop Foreign Key Symbol                                                       { printf("type = 17\n"); }
                  | Force                                                                         { printf("type = 18\n"); }
                  | Lock OptEqual LockType                                                        { printf("type = 19\n"); }
                  | Modify OptColumn SQAnyStr ColDef OptPosition                                  { printf("type = 20\n"); }
                  | Rename IndexKey SQAnyStr To SQAnyStr                                          { printf("type = 21\n"); }
                  | Rename ToAs SQAnyStr                                                          { printf("type = 22\n"); }
                  | WithWithout Validation                                                        { printf("type = 23\n"); }

KeyParts: KeyPart
        | KeyParts Comma KeyPart
KeyPart: SQAnyStr OptSize OptAscDesc { addIdxCol($1, $2, $3); }
OptSize: /* empty */ { $$ = "0"; }
       | LPar IntNum RPar { $$ = $2; }
OptAscDesc: /* empty */ { $$ = "asc"; }
          | Asc  { $$ = "asc"; }
          | Desc { $$ = "desc"; }

ReferenceDefinition: References SQAnyStr LPar KeyParts RPar OptMatch OptAction
OptMatch: /* empty */
        | Match Full
        | Match Partial
        | Match Simple
OptAction: /* empty */
         | On Delete ReferenceOption
         | On Update ReferenceOption
ReferenceOption: Restrict
               | Cascade
               | Set Snull
               | No Action
               | Set Default

CharsetDef: Character Set OptEqual CharsetOptions

ColDef: DataType ColDefOptions

DataType: Bits
        | Nums
        | Times
        | Texts
        | Sets
Bits: Bit SizeOption1  { newCol("bit", -1); }
    | Bool             { newCol("tinyint", 1); }
    | Boolean          { newCol("tinyint", 1); }
Nums: TinyInt SizeOption1 NumOptions          { newCol("tinyint", 1); }
    | SmallInt SizeOption1 NumOptions         { newCol("smallint", 2); }
    | MediumInt SizeOption1 NumOptions        { newCol("mediumint", 3); }
    | Int SizeOption1 NumOptions              { newCol("int", 4); }
    | Integer SizeOption1 NumOptions          { newCol("integer", 4); }
    | BigInt SizeOption1 NumOptions           { newCol("bigint", 8); }
    | Decimal SizeOption1or2 NumOptions       { newCol("decimal", -1); }
    | Dec SizeOption1or2 NumOptions           { newCol("dec", -1); }
    | Numeric SizeOption1or2 NumOptions       { newCol("numeric", -1); }
    | Float SizeOption1or2 NumOptions         { newCol("float", -1); }
    | Double SizeOption2 NumOptions           { newCol("double", 8); }
    | Double Precision SizeOption2 NumOptions { newCol("double", 8); }
    | Real SizeOption2 NumOptions             { newCol("real", 8); }
Times: Date                  { newCol("date", 3); }
     | Datetime SizeOption1  { newCol("datetime", -1); }
     | Timestamp SizeOption1 { newCol("timestamp", -1); }
     | Time SizeOption1      { newCol("time", -1); }
     | Year                  { newCol("year", 1); }
Texts: Binary           { newCol("binary", -1); }
     | Varbinary        { newCol("varbinary", -1); }
     | TinyBlob         { newCol("tinyblob", 256); }        /* 255B + 1*/
     | Blob SizeOption1 { newCol("blob", -1); }             /* 65535 + 2 or opt */
     | MediumBlob       { newCol("mediumblob", 16777218); } /* 16MB - 1B +3 */
     | LongBlob         { newCol("longblob", 4294967299); } /* 4GB - 1B +4 */
     | Char SizeOption1 CharacterSetOptions    { newCol("char", -1); }
     | Varchar SizeOption1 CharacterSetOptions { newCol("varchar", -1); }
     | TinyText CharacterSetOptions            { newCol("tinytext", 256); }
     | Text SizeOption1 CharacterSetOptions    { newCol("text", -1); } /* 65535 + 2 or opt*4 */
     | MediumText CharacterSetOptions          { newCol("mediumtext", 16777218); }
     | LongText CharacterSetOptions            { newCol("longtext", 4294967299); }
Sets: Enum { newCol("enum", 2); }
    | Set  { newCol("set", 2); }
SizeOption1: /* empty */
           | LPar IntNum RPar { setOpt1(atolong($2)); }
SizeOption2: /* empty */
           | LPar IntNum Comma IntNum RPar { setOpt1(atolong($2)); setOpt2(atolong($4)); }
SizeOption1or2: /* empty */
              | LPar IntNum RPar { setOpt1(atolong($2)); }
              | LPar IntNum Comma IntNum RPar { setOpt1(atolong($2)); setOpt2(atolong($4)); }
CharacterSetOptions: /* empty */
                   | Character Set SQAnyStr CollateOptions
CollateOptions: /* empty */
              | CollateOption
NumOptions: /* empty */
          | NumOptions Unsigned
          | NumOptions Zerofill

ColDefOptions: /* empty */
             | ColDefOptions Snull { setColsNull(true); }
             | ColDefOptions Not Snull { setColsNull(false); }
             | ColDefOptions DefaultOption
             | ColDefOptions AutoIncrement
             | ColDefOptions UniqueKey { setHasIdx(true); }
             | ColDefOptions PrimaryKey { setHasPk(true); }
             | ColDefOptions Comments
             | ColDefOptions ColumnFormat ColumnFormatOption
             | ColDefOptions CollateOption
             | ColDefOptions Storage StorageOption
             | ColDefOptions ReferenceDefinition

StorageOption: Disk
             | Memory

UniqueKey: Unique
         | Unique Key
PrimaryKey: Primary
          | Primary Key

Comments: Comment Equal SQAnyStr
        | Comment SQAnyStr


DefaultOption: Default Snull { setColsNull(true); }
             | Default DefaultVal
DefaultVal: SQAnyStr {}

CollateOption: Collate SQAnyStr
             | Collate Equal SQAnyStr

ColumnFormatOption: Fixed
                  | Dynamic
                  | Default

OptColumn: /* empty */
		 | Column

OptPosition: /* empty */ 
		| First
		| After SQAnyStr

OptIndexKey: /* empty */
		   | IndexKey
IndexKey: Index
		| Key

OptIndexType: /* empty */
            | Using Btree
            | Using Hash

OptIndexName: /* empty */
			| SQAnyStr

FulltextSpatial: Fulltext
			   | Spatial

OptConstraintSymbol: /* empty */
				   | Constraint OptSymbol
OptSymbol: /* empty */
		 | Symbol

AlgorithmType: Default
			 | Inplace
             | Copy

OptEqual: /* empty */
		| Equal

OptDefault: /* empty */
		| Default

CharsetOptions: Utf8
              | Utf8mb4
              | SQAnyStr

OptCollateDef: Collate SQAnyStr
             | Collate Equal SQAnyStr

DisableEnable: Disable
			 | Enable

DiscardImport: Discard
			 | Import

LockType: Default
		| None
        | Shared
        | Exclusive

ToAs: To
	| As

WithWithout: With
		   | Without

OptSemi: /* empty */
       | Semi

%%

#include <unistd.h>

int yydebug = 1;

int main(int argc, char* argv[]) {
    int opt;
    bool debug = false;
    while((opt = getopt(argc, argv, "d")) != -1) {
        switch(opt) {
            case 'd':
                // printf("-d is specified\n");
                debug = true;
                break;
            default:
                printf("Usage: %s [-d] \n", argv[0]);
                return 1;
        }
    }

    printf("Input Table Definition: (Please type ^d to end input) \n");

    if(!yyparse()) {
        printf("successfully ended\n");

        // long maxSize, aveSize;
        // calcTotalSize(debug, &maxSize, &aveSize); // debug = true

        // printResult(maxSize, aveSize);
    }

    return 0;
}