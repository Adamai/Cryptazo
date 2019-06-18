const ethereumJS = require('web3')
const web3 = new ethereumJS('http://127.0.0.1:8545', null, { transactionConfirmationBlocks: 1 })

var accounts = [];
var myContract;

//CRIANDO E DANDO DEPLOY NO CONTRATO ------------------------------------------------
/* web3.eth.getAccounts().then(function(result){
    accounts = result;
    console.log(accounts);
});


testContract = new web3.eth.Contract([
    {
        "constant": false,
        "inputs": [
            {
                "name": "_newGreet",
                "type": "string"
            }
        ],
        "name": "setGreet",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "getGreet",
        "outputs": [
            {
                "name": "",
                "type": "string"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "constructor"
    }
]);

testContract.deploy({
    data: "608060405234801561001057600080fd5b506040805180820190915260058082527f68656c6c6f00000000000000000000000000000000000000000000000000000060209092019182526100559160009161005b565b506100f6565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061009c57805160ff19168380011785556100c9565b828001600101855582156100c9579182015b828111156100c95782518255916020019190600101906100ae565b506100d59291506100d9565b5090565b6100f391905b808211156100d557600081556001016100df565b90565b6102a7806101056000396000f30060806040526004361061004b5763ffffffff7c01000000000000000000000000000000000000000000000000000000006000350416639698086b8114610050578063d705a4b5146100ab575b600080fd5b34801561005c57600080fd5b506040805160206004803580820135601f81018490048402850184019095528484526100a99436949293602493928401919081908401838280828437509497506101359650505050505050565b005b3480156100b757600080fd5b506100c061014c565b6040805160208082528351818301528351919283929083019185019080838360005b838110156100fa5781810151838201526020016100e2565b50505050905090810190601f1680156101275780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b80516101489060009060208401906101e3565b5050565b60008054604080516020601f60026000196101006001881615020190951694909404938401819004810282018101909252828152606093909290918301828280156101d85780601f106101ad576101008083540402835291602001916101d8565b820191906000526020600020905b8154815290600101906020018083116101bb57829003601f168201915b505050505090505b90565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061022457805160ff1916838001178555610251565b82800160010185558215610251579182015b82811115610251578251825591602001919060010190610236565b5061025d929150610261565b5090565b6101e091905b8082111561025d57600081556001016102675600a165627a7a72305820abcf4d732cb9cf235c52bad7faa897323549df3f10ef1df221f5bfd3708016ab0029"
}).send({
    from: '0xef56636f70e0a06244c7d39ebafc510532326344',         //usar address gerado pelo ganache
    gas: 4700000
}).then(function(result){
    myContract = result;
    //console.log(myContract);
}); */
// -----------------------------------------------------------------------------------

//TESTANDO FUNÇÃO DO CONTRATO
testContract = new web3.eth.Contract([
    {
        "constant": false,
        "inputs": [
            {
                "name": "_newGreet",
                "type": "string"
            }
        ],
        "name": "setGreet",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "getGreet",
        "outputs": [
            {
                "name": "",
                "type": "string"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "constructor"
    }
],'0xea0518b097c3aecc80dace5346ea5baf3d5cae73');        //usar address gerado pelo contract

/* testContract.methods.setGreet('aloha').send({
    from: '0xEF56636f70e0a06244c7d39EBAfc510532326344'  //usar address gerado pelo ganache
}); */

testContract.methods.getGreet().call().then(console.log);


//test.deploy().send().catch(e => console.log(e));