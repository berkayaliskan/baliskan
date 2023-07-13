*&---------------------------------------------------------------------*
*& Report zot_05_p_twitter
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_05_p_twitter.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_twid  TYPE c LENGTH 3,
              p_tweet TYPE c LENGTH 255.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  PARAMETERS: p_send   RADIOBUTTON GROUP g1,
              p_update RADIOBUTTON GROUP g1,
              p_delete RADIOBUTTON GROUP g1,
              p_disply RADIOBUTTON GROUP g1.
SELECTION-SCREEN END OF BLOCK b2.

DATA lt_tweet TYPE TABLE OF zot_05_t_p_tweet.


START-OF-SELECTION.

  IF p_twid EQ space AND p_send EQ 'X' OR p_twid EQ space AND p_update EQ 'X' OR p_twid EQ space AND p_delete EQ 'X'.
    MESSAGE 'Tweet ID giriniz!' TYPE 'I'.
  ELSE.
    CASE 'X'.
      WHEN p_send.
        APPEND VALUE #( tweetid = p_twid
                        tweet = p_tweet
                            ) TO lt_tweet.
        MODIFY zot_05_t_p_tweet FROM TABLE lt_tweet.
        COMMIT WORK AND WAIT.
      WHEN p_update.
        UPDATE zot_05_t_p_tweet SET tweet = p_tweet
   WHERE tweetid = p_twid.
        COMMIT WORK AND WAIT.
      WHEN p_delete.
        DELETE FROM zot_05_t_p_tweet WHERE tweetid = p_twid.
        COMMIT WORK AND WAIT.
      WHEN p_disply.
        SELECT tweetid,
               tweet
        FROM zot_05_t_p_tweet
        INTO TABLE @DATA(abapitter).
        cl_demo_output=>display( abapitter ).
    ENDCASE.
  ENDIF.
