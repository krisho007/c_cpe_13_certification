using my.dataModel as my from '../db/schema';

service EscalationManagementService {
    entity Escalations as projection on my.Escalations 
    actions{
        action resolve();
    };
    entity Comments as projection on my.Comments;
    entity StatusList as projection on my.Statuses;   

}