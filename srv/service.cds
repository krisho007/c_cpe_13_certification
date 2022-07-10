using my.dataModel as my from '../db/schema';
using { API_PURCHASEORDER_PROCESS_SRV as external } from './external/API_PURCHASEORDER_PROCESS_SRV';

@path: 'ems'
service EscalationManagementService {
    entity Escalations as projection on my.Escalations 
    actions{
        action resolve();
    };
    annotate Escalations with @odata.draft.enabled;
    entity Comments as projection on my.Comments;
    entity Statuses as projection on my.Statuses; 

    entity POSchedules as projection on external.A_PurchaseOrderScheduleLine;  
}