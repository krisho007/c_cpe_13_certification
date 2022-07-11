const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const po = await cds.connect.to('API_PURCHASEORDER_PROCESS_SRV');

    this.on('resolve', async (req) => {
        const tx = cds.tx(req);
        const res = await tx.run(
            UPDATE('Escalations')
                .set({ 'Status_code': 'CMP' })
                .where({ ID: req.params[0] })
        );
    });

    this.on('READ', 'PurchaseOrders', async (req) => {
        let result = po.tx(req).send(
            {
                query: req.query,
                headers: {
                    apiKey: process.env.apiKey
                }
            }
        );
        return result;
    });

    this.on('READ', 'Escalations', async (req, next) => {

        if (!req.query.SELECT.columns) return next();
        const expandIndex = req.query.SELECT.columns.findIndex(
            ({ expand, ref }) => expand && ref[0] === "purchaseOrder"
        );
        if (expandIndex < 0) return next();

        // Remove expand from query
        req.query.SELECT.columns.splice(expandIndex, 1);

        // Make sure supplier_ID will be returned
        if (!req.query.SELECT.columns.indexOf('*') >= 0 &&
            !req.query.SELECT.columns.find(
                column => column.ref && column.ref.find((ref) => ref == "purchaseOrder_ID"))
        ) {
            req.query.SELECT.columns.push({ ref: ["purchaseOrder_ID"] });
        }

        const escalations = await next();

        const asArray = x => Array.isArray(x) ? x : [ x ];

        // Request all associated suppliers
        const poIds = asArray(escalations).map(escalation => escalation.purchaseOrder_ID);
        const purchaseOrders = await po.run(SELECT.from('API_PURCHASEORDER_PROCESS_SRV.A_PurchaseOrder').where({ PurchaseOrder: poIds }));

        // Convert in a map for easier lookup
        const purchaseOrdersMap = {};
        for (const purchaseOrder of purchaseOrders)
        purchaseOrdersMap[purchaseOrder.PurchaseOrder] = purchaseOrder;

        // Add suppliers to result
        for (const escalation of asArray(escalations)) {
            escalation.purchaseOrder = purchaseOrdersMap[note.purchaseOrder_ID];
        }

        return escalations;        
    });
});
