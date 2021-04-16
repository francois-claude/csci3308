// Imports the server.js file to be tested.
let server = require("../server");
//Assertion (Test Driven Development) and Should, Expect(Behaviour driven development) library
let chai = require("chai");
// Chai HTTP provides an interface for live integration testing of the API's.
let chaiHttp = require("chai-http");
chai.should();
chai.use(chaiHttp); 
const { expect } = chai;
var assert = chai.assert;


//Import complete
describe("Server!", () => {
      // Add your test cases here
    
      it("positive addition", done => {
        chai
          .request(server)
          .post("/add")
          .send({
            num1: 4,
            num2: 4
          })
          .end((err, response) => {
            expect(response.body.result).to.equal(8);
            done();
          });
      });
    
      it("positive division", done => {
        chai
          .request(server)
          .post("/divide")
          .send({
            num1: 4,
            num2: 4
          })
          .end((err, response) => {
            expect(response.body.result).to.equal(1);
            done();
          });
      });
    
    
      it("negative addition", done => {
        chai
          .request(server)
          .post("/add")
          .send({
            num1: "string",
            num2: 1
          })
          .end((err, response) => {
            assert.strictEqual(response.status, 400);
            done();
          });
      });
    
      it("negative division", done => {
        chai
          .request(server)
          .post("/divide")
          .send({
            num1: 4,
            num2: 0
          })
          .end((err, response) => {
            assert.strictEqual(response.status, 400);
            done();
          });
      });
    
    });