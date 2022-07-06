using { managed, cuid, sap.common.CodeList as CodeList } from '@sap/cds/common';
namespace my.dataModel;

entity Statuses: CodeList{
    key code: String(3)
}

type Status : Association to Statuses;

entity Comments: managed, cuid{
    comment: String;
    escalation: Association to Escalations;
}

entity Escalations: managed, cuid {
    description     : String (80);
    material: String(30);
    expectedDate: Date;
    status: Status;
    comments: Composition of many Comments on comments.escalation = $self;
};