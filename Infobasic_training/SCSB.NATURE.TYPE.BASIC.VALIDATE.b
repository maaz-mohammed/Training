* Version 2 02/06/00  GLOBUS Release No. G11.0.00 29/06/00
SUBROUTINE SCSB.NATURE.TYPE.BASIC.VALIDATE
*-----------------------------------------------------------------------------
    !** Template FOR validation routines
* @author youremail@temenos.com
* @stereotype validator
* @package infra.eb
*!
*-----------------------------------------------------------------------------
*** <region name= Modification History>
*-----------------------------------------------------------------------------
* 07/06/06 - BG_100011433
*            Creation
*-----------------------------------------------------------------------------
*** </region>
*** <region name= Main section>
    $INSERT I_COMMON
    $INSERT I_EQUATE
    $INSERT I_F.SCSB.NATURE.TYPE.BASIC
    $INSERT I_F.EB.ERROR

    GOSUB INITIALISE
    GOSUB PROCESS.MESSAGE
RETURN
*** </region>
*-----------------------------------------------------------------------------
VALIDATE:
* TODO - Add the validation code here.
* Set AF, AV and AS to the field, multi value and sub value and invoke STORE.END.ERROR
* Set ETEXT to point to the EB.ERROR.TABLE
    BEGIN CASE
        CASE Y.RATE.TYPE EQ "PERIODIC"
            IF Y.RATE.BASIC NE "" OR Y.RATE.FIXED NE "" THEN
                ETEXT=Y.MSSG1
		    AF=SNTB.RATE.TYPE
                CALL STORE.END.ERROR()
			IF Y.RATE.PERIODIC NE "" THEN
			ETEXT=Y.MSSG2
			AF=SNTB.RATE.VALUE.PERIODIC
                CALL STORE.END.ERROR()
            END
            END
            
        CASE Y.RATE.TYPE EQ "FLOATING"
            IF Y.RATE.PERIODIC NE "" OR Y.RATE.FIXED NE "" THEN
                 ETEXT=Y.MSSG1
			AF=SNTB.RATE.TYPE
                CALL STORE.END.ERROR()
			
			IF Y.RATE.BASIC NE "" THEN
                ETEXT=Y.MSSG2
		    AF=SNTB.RATE.VALUE.BASIC
                CALL STORE.END.ERROR()
            END
            END
            
    
        CASE Y.RATE.TYPE EQ "FIXED"
            IF Y.RATE.BASIC NE "" OR Y.RATE.PERIODIC NE "" THEN
                ETEXT=Y.MSSG1
		    AF=SNTB.RATE.TYPE
                CALL STORE.END.ERROR()
		
			IF Y.RATE.FIXED NE "" THEN
                ETEXT=Y.MSSG2
 		    AF=SNTB.RATE.VALUE.FIXED
                CALL STORE.END.ERROR()
            END
            END
            
    
    END CASE
*      AF = MY.FIELD.NAME                 <== Name of the field
*      ETEXT = 'EB-EXAMPLE.ERROR.CODE'    <== The error code
*      CALL STORE.END.ERROR               <== Needs to be invoked per error

RETURN
*-----------------------------------------------------------------------------
*** <region name= Initialise>
INITIALISE:
***
    Y.RATE.TYPE=R.NEW(SNTB.RATE.TYPE)
    Y.RATE.PERIODIC=R.NEW(SNTB.RATE.VALUE.PERIODIC)
    Y.RATE.BASIC=R.NEW(SNTB.RATE.VALUE.BASIC)
    Y.RATE.FIXED=R.NEW(SNTB.RATE.VALUE.FIXED)
 FN.ERR="F.EB.ERROR"
 F.ERR=""
 CALL OPF(FN.ERR,F.ERR)

 Y.ERR.ID="EB-CUSTOM.ERROR"
 CALL F.READ(FN.ERR,Y.ERR.ID,ERR.REC,F.ERR,ERR.CODE)
 Y.MSSG1=ERR.REC<EB.ERR.ERROR.MSG,1>
Y.MSSG2=ERR.REC<EB.ERR.ERROR.MSG,2>
*
RETURN
*** </region>
*-----------------------------------------------------------------------------
*** <region name= Process Message>
PROCESS.MESSAGE:
    BEGIN CASE
        CASE MESSAGE EQ ''        ;* Only during commit...
            BEGIN CASE
                CASE V$FUNCTION EQ 'D'
                    GOSUB VALIDATE.DELETE
                CASE V$FUNCTION EQ 'R'
                    GOSUB VALIDATE.REVERSE
                CASE OTHERWISE        ;* The real VALIDATE...
                    GOSUB VALIDATE
            END CASE
        CASE MESSAGE EQ 'AUT' OR MESSAGE EQ 'VER'     ;* During authorisation and verification...
            GOSUB VALIDATE.AUTHORISATION
    END CASE
*
RETURN
*** </region>
*-----------------------------------------------------------------------------
*** <region name= VALIDATE.DELETE>
VALIDATE.DELETE:
* Any special checks for deletion

RETURN
*** </region>
*-----------------------------------------------------------------------------
*** <region name= VALIDATE.REVERSE>
VALIDATE.REVERSE:
* Any special checks for reversal

RETURN
*** </region>
*-----------------------------------------------------------------------------
*** <region name= VALIDATE.AUTHORISATION>
VALIDATE.AUTHORISATION:
* Any special checks for authorisation

RETURN
*** </region>
*-----------------------------------------------------------------------------
END
