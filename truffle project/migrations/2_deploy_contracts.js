const Test = artifacts.require("Test");
const TazoFactory = artifacts.require("TazoFactory")
const TazoFuse = artifacts.require("TazoFuse")
const TazoHelper = artifacts.require("TazoHelper")
const TazoBattle = artifacts.require("TazoBattle")
const TazoOwnership = artifacts.require("TazoOwnership")


module.exports = function(deployer) {
  deployer.deploy(Test);
  deployer.deploy(TazoFactory);
  deployer.deploy(TazoFuse);
  deployer.deploy(TazoHelper);
  deployer.deploy(TazoBattle);
  deployer.deploy(TazoOwnership);
};
