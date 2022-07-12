// using {EscalationManagementService as my} from './service';

// annotate my.Escalations with @(
//     Common.SideEffects #PurchaseOrderUpdated : {
//         SourceProperties : [purchaseOrder_ID],
//         TargetEntities   : [purchaseOrder]
//     },
//     UI                                       : {
//         FieldGroup #GenInfo : {
//             $Type : 'UI.FieldGroupType',
//             Data  : [
//                 {
//                     $Type : 'UI.DataField',
//                     Value : description,
//                     Label : 'Description',
//                 },
//                 {
//                     $Type : 'UI.DataField',
//                     Value : purchaseOrder_ID,
//                 },
//                 {
//                     $Type : 'UI.DataField',
//                     Value : purchaseOrder.Supplier,
//                     Label : 'Supplier',
//                 },
//                 {
//                     $Type : 'UI.DataField',
//                     Value : material,
//                     Label : 'Material No.',
//                 },
//                 {
//                     $Type : 'UI.DataField',
//                     Value : expectedDate,
//                     Label : 'Expected Date',
//                 },
//                 {
//                     $Type : 'UI.DataField',
//                     Value : status_code,
//                     Label : 'Status',
//                 },
//             ],
//         },
//         SelectionFields     : [
//             status_code,
//             purchaseOrder_ID
//         ],
//         LineItem            : [
//             {
//                 $Type  : 'UI.DataFieldForAction',
//                 Action : 'EscalationManagementService.resolve',
//                 Label  : 'Resolve'
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Description',
//                 Value : description,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Value : purchaseOrder_ID,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Value : purchaseOrder.Supplier,
//                 Label : 'Supplier',
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Status',
//                 Value : status_code,
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Value : material,
//                 Label : 'Material No.',
//             },
//             {
//                 $Type : 'UI.DataField',
//                 Value : expectedDate,
//                 Label : 'Expected Date',
//             }
//         ],
//         Facets              : [
//             {
//                 $Type  : 'UI.ReferenceFacet',
//                 Target : '@UI.FieldGroup#GenInfo',
//                 Label  : 'General Information'
//             },
//             {
//                 $Type  : 'UI.ReferenceFacet',
//                 Target : 'comments/@UI.LineItem',
//                 Label  : 'Comments'
//             },
//         ],
//     }
// );

// annotate my.Comments with @(UI : {
//     Identification : [
//         {
//             $Type : 'UI.DataField',
//             Value : comment,
//             Label : 'Comment',
//         },
//         {
//             $Type : 'UI.DataField',
//             Value : createdAt,
//         },
//     ],
//     LineItem       : [
//         {Value : comment, },
//         {Value : createdAt, }
//     ],
//     Facets         : [{
//         $Type  : 'UI.ReferenceFacet',
//         Target : '@UI.Identification',
//         Label  : ''
//     }]
// });

// annotate my.PurchaseOrders with @(UI : {
//     SelectionFields : [
//         ID,
//         PurchaseOrderType,
//         Supplier
//     ],
//     LineItem        : [
//         {Value : ID, },
//         {Value : PurchaseOrderType, },
//         {Value : Supplier, },
//         {Value : SupplierPhoneNumber, }
//     ],
// });

// annotate my.PurchaseOrder with {
//     ID                  @(Common.Label : 'Purchase Order No.')  @readonly;
//     Supplier            @(Common.Label : 'Supplier')  @readonly;
//     SupplierPhoneNumber @(Common.Label : 'Supplier Ph.no')  @readonly;
// };

// annotate my.Escalations with {
//     description
//                   @mandatory;
//     purchaseOrder @(Common.Label : 'Purchase Order No.')
//                   @mandatory
//                   @(Common : {ValueList : {
//         $Type          : 'Common.ValueListType',
//         CollectionPath : 'PurchaseOrders',
//         Parameters     : [
//             {
//                 $Type             : 'Common.ValueListParameterInOut',
//                 ValueListProperty : 'ID',
//                 LocalDataProperty : 'purchaseOrder_ID'
//             },
//             {
//                 $Type             : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'PurchaseOrderType'
//             },
//             {
//                 $Type             : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'Supplier'
//             }
//         ],
//     }, });
//     ExpectedDate
//                   @mandatory;
//     status
//                   @Common.ValueListWithFixedValues : true
//                   @Common.Text                     : status.name
//                   @Common.TextArrangement          : #TextFirst;
// }
