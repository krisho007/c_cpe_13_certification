using my.dataModel as my from '../db/schema';

service EscalationManagementService {
    entity Escalations as projection on my.Escalations 
    actions{
        action resolve();
    };
    entity Comments as projection on my.Comments;
    entity Statuses as projection on my.Statuses;   

    @readonly 
    entity PurchaseOrders as projection on my.PurchaseOrders;
}