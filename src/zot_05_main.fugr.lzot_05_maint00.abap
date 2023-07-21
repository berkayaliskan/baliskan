*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZOT_05_T_PERS...................................*
DATA:  BEGIN OF STATUS_ZOT_05_T_PERS                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_05_T_PERS                 .
CONTROLS: TCTRL_ZOT_05_T_PERS
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZOT_05_T_P_AILE.................................*
DATA:  BEGIN OF STATUS_ZOT_05_T_P_AILE               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_05_T_P_AILE               .
CONTROLS: TCTRL_ZOT_05_T_P_AILE
            TYPE TABLEVIEW USING SCREEN '0007'.
*...processing: ZOT_05_T_P_ATUR.................................*
DATA:  BEGIN OF STATUS_ZOT_05_T_P_ATUR               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_05_T_P_ATUR               .
CONTROLS: TCTRL_ZOT_05_T_P_ATUR
            TYPE TABLEVIEW USING SCREEN '0004'.
*...processing: ZOT_05_T_P_EGTM.................................*
DATA:  BEGIN OF STATUS_ZOT_05_T_P_EGTM               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_05_T_P_EGTM               .
CONTROLS: TCTRL_ZOT_05_T_P_EGTM
            TYPE TABLEVIEW USING SCREEN '0008'.
*...processing: ZOT_05_T_P_ETUR.................................*
DATA:  BEGIN OF STATUS_ZOT_05_T_P_ETUR               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_05_T_P_ETUR               .
CONTROLS: TCTRL_ZOT_05_T_P_ETUR
            TYPE TABLEVIEW USING SCREEN '0005'.
*...processing: ZOT_05_T_P_ILTSM................................*
DATA:  BEGIN OF STATUS_ZOT_05_T_P_ILTSM              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_05_T_P_ILTSM              .
CONTROLS: TCTRL_ZOT_05_T_P_ILTSM
            TYPE TABLEVIEW USING SCREEN '0006'.
*...processing: ZOT_05_T_P_ITUR.................................*
DATA:  BEGIN OF STATUS_ZOT_05_T_P_ITUR               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_05_T_P_ITUR               .
CONTROLS: TCTRL_ZOT_05_T_P_ITUR
            TYPE TABLEVIEW USING SCREEN '0003'.
*...processing: ZOT_05_T_P_MAST.................................*
DATA:  BEGIN OF STATUS_ZOT_05_T_P_MAST               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_05_T_P_MAST               .
CONTROLS: TCTRL_ZOT_05_T_P_MAST
            TYPE TABLEVIEW USING SCREEN '0002'.
*...processing: ZOT_05_T_P_TWEET................................*
DATA:  BEGIN OF STATUS_ZOT_05_T_P_TWEET              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_05_T_P_TWEET              .
CONTROLS: TCTRL_ZOT_05_T_P_TWEET
            TYPE TABLEVIEW USING SCREEN '0009'.
*...processing: ZOT_05_T_SPORT..................................*
DATA:  BEGIN OF STATUS_ZOT_05_T_SPORT                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_05_T_SPORT                .
CONTROLS: TCTRL_ZOT_05_T_SPORT
            TYPE TABLEVIEW USING SCREEN '0011'.
*...processing: ZOT_05_T_ZMN....................................*
DATA:  BEGIN OF STATUS_ZOT_05_T_ZMN                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZOT_05_T_ZMN                  .
CONTROLS: TCTRL_ZOT_05_T_ZMN
            TYPE TABLEVIEW USING SCREEN '0010'.
*.........table declarations:.................................*
TABLES: *ZOT_05_T_PERS                 .
TABLES: *ZOT_05_T_P_AILE               .
TABLES: *ZOT_05_T_P_ATUR               .
TABLES: *ZOT_05_T_P_EGTM               .
TABLES: *ZOT_05_T_P_ETUR               .
TABLES: *ZOT_05_T_P_ILTSM              .
TABLES: *ZOT_05_T_P_ITUR               .
TABLES: *ZOT_05_T_P_MAST               .
TABLES: *ZOT_05_T_P_TWEET              .
TABLES: *ZOT_05_T_SPORT                .
TABLES: *ZOT_05_T_ZMN                  .
TABLES: ZOT_05_T_PERS                  .
TABLES: ZOT_05_T_P_AILE                .
TABLES: ZOT_05_T_P_ATUR                .
TABLES: ZOT_05_T_P_EGTM                .
TABLES: ZOT_05_T_P_ETUR                .
TABLES: ZOT_05_T_P_ILTSM               .
TABLES: ZOT_05_T_P_ITUR                .
TABLES: ZOT_05_T_P_MAST                .
TABLES: ZOT_05_T_P_TWEET               .
TABLES: ZOT_05_T_SPORT                 .
TABLES: ZOT_05_T_ZMN                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
