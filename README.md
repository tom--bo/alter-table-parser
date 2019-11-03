# alter-table-parser

parser for `alter table` syntax

## How to use

```
make
```

you can use as simple script

```sh
$ ./bin/atp
Input Table Definition: (Please type ^d to end input)
alter table t1 add column c45 varchar(45) after c44, algorithm inplace;
type = 1
type = 7
successfully ended
```


## Supported Syntax

Subset of `ALTER TABLE` syntax based on MySQL 5.7

```sql
ALTER TABLE tbl_name
    [alter_specification [, alter_specification] ...]

alter_specification:
    ADD [COLUMN] col_name column_definition [FIRST | AFTER col_name]
  | ADD {INDEX|KEY} [index_name] [index_type] (key_part,...)
  | ADD {FULLTEXT|SPATIAL} [INDEX|KEY] [index_name] (key_part,...)
  | ADD [CONSTRAINT [symbol]] PRIMARY KEY [index_type] (key_part,...)
  | ADD [CONSTRAINT [symbol]] UNIQUE [INDEX|KEY] [index_name] [index_type] (key_part,...)
  | ADD [CONSTRAINT [symbol]] FOREIGN KEY [index_name] (col_name,...) reference_definition
  | ALGORITHM [=] {DEFAULT|INPLACE|COPY}
  | ALTER [COLUMN] col_name {SET DEFAULT literal | DROP DEFAULT}
  | CHANGE [COLUMN] old_col_name new_col_name column_definition [FIRST|AFTER col_name]
  | [DEFAULT] CHARACTER SET [=] charset_name [COLLATE [=] collation_name]
  | CONVERT TO CHARACTER SET charset_name [COLLATE collation_name]
  | {DISABLE|ENABLE} KEYS
  | {DISCARD|IMPORT} TABLESPACE
  | DROP [COLUMN] col_name
  | DROP {INDEX|KEY} index_name
  | DROP PRIMARY KEY
  | DROP FOREIGN KEY fk_symbol
  | FORCE
  | LOCK [=] {DEFAULT|NONE|SHARED|EXCLUSIVE}
  | MODIFY [COLUMN] col_name column_definition [FIRST | AFTER col_name]
  | RENAME {INDEX|KEY} old_index_name TO new_index_name
  | RENAME [TO|AS] new_tbl_name
  | {WITHOUT|WITH} VALIDATION
  | ORDER BY col_name [, col_name] ...

key_part:
    col_name [(length)] [ASC | DESC]

reference_definition:
    REFERENCES tbl_name (key_part,...)
      [MATCH FULL | MATCH PARTIAL | MATCH SIMPLE]
      [ON DELETE reference_option]
      [ON UPDATE reference_option]

reference_option:
    RESTRICT | CASCADE | SET NULL | NO ACTION | SET DEFAULT

... etc
```

### Not supported syntax

TBD

### Will be supported

TBD

## How to test

Exec `make test`!
Please see more Makefile or `tests` dir.

```
make test
```



