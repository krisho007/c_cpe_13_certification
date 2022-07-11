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
        return po.run(req.query);
    });    

});