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




describe("Server!", () => {

  // Sample test case given to test / endpoint. 
  it("Returns the default welcome message", done => {
    chai
      .request(server)
      .get("/")
      .end((err, res) => {
        expect(res).to.have.status(200);
        expect(res.body.status).to.equals("success");
        assert.strictEqual(res.body.message, "welcome!");
        done();
      });
  });

  // Please add your test cases here.
  it("Returns operations", done => {
    chai
      .request(server)
      .get("/operations")
      .end((err, res) => {
        expect(res).to.have.status(200);
        res.body.should.be.a('array');
        res.body.length.should.not.be.eq(0);
        done();
      });
  });

  it("Returns details of an operation", done => {
    chai
      .request(server)
      .get("/operations/1")
      .end((err, res) => {
        expect(res).to.have.status(200);
        expect(res.body.id).to.equals(1);
        expect(res.body).to.have.property('name');
        expect(res.body).to.have.property('sign');
        done();
      });
  });

  it("Verifies properties", done => {
    chai
      .request(server)
      .post("/operations").send({
        name: "division",
        sign: "/"
      })
      .end((err, res) => {
        expect(res).to.have.status(201);
        expect(res.body.id).to.equals(4);
        expect(res.body.name).to.equals('division');
        expect(res.body.sign).to.equals('/');
        done();
      });
  });


});