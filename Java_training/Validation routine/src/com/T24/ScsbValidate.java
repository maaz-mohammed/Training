package com.T24;

import com.temenos.api.TField;
import com.temenos.api.TStructure;
import com.temenos.api.TValidationResponse;
import com.temenos.t24.api.complex.eb.templatehook.TransactionContext;
import com.temenos.t24.api.hook.system.RecordLifecycle;
import com.temenos.t24.api.records.ebscsbnaturetype.EbScsbNatureTypeRecord;


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
        switch (rateType.getValue().toString().toLowerCase()){
        case "periodic":
            if(!(basicRate.getValue().isEmpty() && fixedRate.getValue().isEmpty()))
            {
                rateType.setError("EB-CUSTOM.ERROR");
                if(!(periodicRate.getValue().isEmpty()))
                {
                periodicRate.setError("EB-CUSTOM.SCSB.ERROR");
                }
            }
            break;
        case "floating":
            if(!(periodicRate.getValue().isEmpty() && fixedRate.getValue().isEmpty()))
            {
                rateType.setError("EB-CUSTOM.ERROR");
                if(!(basicRate.getValue().isEmpty())){
                basicRate.setError("EB-CUSTOM.SCSB.ERROR");
                }
            }
            break;
        case "fixed":
            if(!(basicRate.getValue().isEmpty() && periodicRate.getValue().isEmpty()))
            {
                rateType.setError("EB-CUSTOM.ERROR");
                if(!(fixedRate.getValue().isEmpty())){
                fixedRate.setError("EB-CUSTOM.SCSB.ERROR");
                }
            }
            break;
                
        
        }
        return tableRec.getValidationResponse();
         
    }
    

}
