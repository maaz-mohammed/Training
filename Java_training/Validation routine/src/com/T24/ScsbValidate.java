package com.T24;

import com.temenos.api.TField;
import com.temenos.api.TStructure;
import com.temenos.api.TValidationResponse;
import com.temenos.t24.api.complex.eb.templatehook.TransactionContext;
import com.temenos.t24.api.hook.system.RecordLifecycle;
import com.temenos.t24.api.records.eberror.EbErrorRecord;
import com.temenos.t24.api.records.ebscsbnaturetype.EbScsbNatureTypeRecord;
import com.temenos.t24.api.system.DataAccess;

/**
 * TODO: Document me!
 *
 * @author mohammedmaaz
 *
 */
public class ScsbValidate extends RecordLifecycle {

    @Override
    public TValidationResponse validateRecord(String application, String currentRecordId, TStructure currentRecord,
            TStructure unauthorisedRecord, TStructure liveRecord, TransactionContext transactionContext) {
        // TODO Auto-generated method stub
        EbScsbNatureTypeRecord tableRec = new EbScsbNatureTypeRecord(currentRecord);
        TField rateType=tableRec.getRateType();
        TField basicRate = tableRec.getRateValueBasic();
        TField fixedRate = tableRec.getRateValueFixed();
        TField periodicRate = tableRec.getRateValuePeriodic();
        DataAccess da = new DataAccess(this);
        
        EbErrorRecord errorMssg = new EbErrorRecord(da.getRecord("EB.ERROR", "EB-CUSTOM.ERROR"));
        String errormssg1 = errorMssg.getErrorMsg(0).toString();
        String errormssg2 = errorMssg.getErrorMsg(1).toString();
        switch (rateType.getValue().toString().toLowerCase()){
        case "periodic":
            if(!(basicRate.getValue().isEmpty() && fixedRate.getValue().isEmpty()))
            {
                rateType.setError(errormssg1);
                if(!(periodicRate.getValue().isEmpty()))
                {
                periodicRate.setError(errormssg2);
                }
            }
            break;
        case "floating":
            if(!(periodicRate.getValue().isEmpty() && fixedRate.getValue().isEmpty()))
            {
                rateType.setError(errormssg1);
                if(!(basicRate.getValue().isEmpty())){
                basicRate.setError(errormssg2);
                }
            }
            break;
        case "fixed":
            if(!(basicRate.getValue().isEmpty() && periodicRate.getValue().isEmpty()))
            {
                rateType.setError(errormssg1);
                if(!(fixedRate.getValue().isEmpty())){
                fixedRate.setError(errormssg2);
                }
            }
            break;
                
        
        }
                
        return tableRec.getValidationResponse();
    }
    

}
