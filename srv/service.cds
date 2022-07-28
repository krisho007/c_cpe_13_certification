using my.dataModel as my from '../db/schema';

@path: 'ems'
@requires: ['manager_scope', 'purchaser_scope']
service EscalationManagementService {
    entity Escalations @(restrict : [
        { grant: ['READ','CREATE'], to: ['purchaser_scope'] },
        { grant: ['READ','UPDATE'], to: ['manager_scope'] }
        ]) as projection on my.Escalations 
        actions{
            @(
                cds.odata.bindingparameter.name : '_it',
                Common.SideEffects              : {
                    TargetProperties : ['_it/status_code']
                }
            ) 
            action resolve();
        };
    annotate Escalations with @odata.draft.enabled;

    entity Comments as projection on my.Comments;
    entity Statuses as projection on my.Statuses;
       
    @readonly 
    entity PurchaseOrders as projection on my.PurchaseOrders;
}