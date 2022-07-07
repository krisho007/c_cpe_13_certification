const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

    this.on('resolve', async (req) => {
        const tx = cds.tx(req);
        const res = await tx.run(
            UPDATE('Escalations')
                .set({ 'Status_code': 'CMP' })
                .where({ ID: req.params[0] })
        );
    });

});