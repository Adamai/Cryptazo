const Test = artifacts.require("Test");
const TazoFactory = artifacts.require("TazoFactory")

module.exports = function(deployer) {
  deployer.deploy(Test);
  deployer.deploy(TazoFactory);
};
