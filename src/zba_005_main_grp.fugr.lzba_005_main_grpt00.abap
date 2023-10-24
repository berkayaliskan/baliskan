*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZBA_005_T_DELVRY................................*
DATA:  BEGIN OF STATUS_ZBA_005_T_DELVRY              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZBA_005_T_DELVRY              .
CONTROLS: TCTRL_ZBA_005_T_DELVRY
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZBA_005_T_STOCK.................................*
DATA:  BEGIN OF STATUS_ZBA_005_T_STOCK               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZBA_005_T_STOCK               .
CONTROLS: TCTRL_ZBA_005_T_STOCK
            TYPE TABLEVIEW USING SCREEN '0002'.
*.........table declarations:.................................*
TABLES: *ZBA_005_T_DELVRY              .
TABLES: *ZBA_005_T_STOCK               .
TABLES: ZBA_005_T_DELVRY               .
TABLES: ZBA_005_T_STOCK                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
