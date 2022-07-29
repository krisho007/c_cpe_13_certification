const cds = require("@sap/cds");
const { expect, GET, POST } = cds.test.in(__dirname, "..").run(
    "serve", "--with-mocks", "--in-memory");
    
  // New changes to push the code to github  -2
describe("Testing OData APIs", () => {
  it("test status codes", async () => {
    const { data } = await GET`/ems/Statuses?$select=code`;
    expect(data.value).to.eql([
      { code: "CMP" },
      { code: "DRF" },
      { code: "INP" },
    ]);
  });

  it("test action resolve", async () => {
    // Step 1: Create the draft data
    const { data: draft } = await POST`/ems/Escalations ${{
      description: "test",
      purchaseOrder_ID: "9000000001",
      expectedDate: "2022-05-27",
    }}`;

    // Step 2: Save the draft to create a new escalation
    const { data: post } = await POST(
      `/ems/Escalations(ID=${draft.ID},IsActiveEntity=false)/EscalationManagementService.draftActivate`
    );

    // Step 3: Read the escalation before executing the resolve action
    let {
      data: readBeforeAction,
    } = await GET`/ems/Escalations(ID=${post.ID},IsActiveEntity=true)`;

    // Step 4: Check if the initial status is 'INP - In process
    expect(readBeforeAction.status_code).to.eql("INP");

    // Step 5: Perform Resolve Action
    await POST`/ems/Escalations(ID=${draft.ID},IsActiveEntity=false)/EscalationManagementService.resolve`;

    // Step 6: Read the escalation after executing the resolve action
    let {
      data: readAfterAction,
    } = await GET`/ems/Escalations(ID=${post.ID},IsActiveEntity=true)`;

    // Step 7: Check if the escalation is updated to the status 'CMP' - Completed
    expect(readAfterAction.status_code).to.eql("CMP");
  });
});
