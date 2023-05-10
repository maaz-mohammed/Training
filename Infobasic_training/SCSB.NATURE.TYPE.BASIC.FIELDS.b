*-----------------------------------------------------------------------------
* <Rating>-7</Rating>
*-----------------------------------------------------------------------------
SUBROUTINE SCSB.NATURE.TYPE.BASIC.FIELDS
*-----------------------------------------------------------------------------
*<doc>
* Template for field definitions routine EB.SCSB.NATURE.TYPE.BASIC.FIELDS
*
* @author tcoleman@temenos.com
* @stereotype fields template
* @uses Table
* @public Table Creation
* @package infra.eb
* </doc>
*-----------------------------------------------------------------------------
* Modification History :
*
* 19/10/07 - EN_10003543
*            New Template changes
*
* 14/11/07 - BG_100015736
*            Exclude routines that are not released
*-----------------------------------------------------------------------------
*** <region name= Header>
*** <desc>Inserts and control logic</desc>
    $INSERT I_COMMON
    $INSERT I_EQUATE
    $INSERT I_DataTypes
*** </region>
*-----------------------------------------------------------------------------
    ID.F='ID'
    ID.N=10
    ID.T=""
*-----------------------------------------------------------------------------
    CALL Table.addFieldWithEbLookup("RATE.TYPE","RATES",'');
    CALL Table.addFieldDefinition("RATE.VALUE.PERIODIC",30,"A",'')
    CALL Field.setCheckFile("PERIODIC.INTEREST");
    CALL Table.addFieldDefinition("RATE.VALUE.BASIC",30,"A",'')
    CALL Field.setCheckFile("BASIC.INTEREST");
    CALL Table.addFieldDefinition("RATE.VALUE.FIXED",30,"AMT",'');
    CALL Table.addYesNoField("ALLOW.BROKER.UPDATE","","");
    CALL Table.addYesNoField("ALLOW.FIDU.UPDATE","","");
    CALL Table.addFieldDefinition("PRODUCT.ALLOWED",30,"A",'');
    CALL Field.setCheckFile("AA.PRODUCT.CATALOG");
    CALL Table.addFieldWithEbLookup("CURRENCY","CURRENCY.TYPE",'');
* ----------------------------------------------------------------------------
    CALL Table.setAuditPosition ;* Poputale audit information
*-----------------------------------------------------------------------------
RETURN
*-----------------------------------------------------------------------------
END
